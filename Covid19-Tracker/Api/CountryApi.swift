//
//  CountryApi.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-06-07.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import Foundation

class CountryApi: ObservableObject {
    private var baseUrlStr = "https://disease.sh/v2/"
    var country: Country?
    var countryHistory: CountryHistory?
    @Published var countryHistoryCases: [(Date, Int)] = [(Date, Int)]()
    
    func getCountryHistoryCompletion() {
        DispatchQueue.main.async {
            self.countryHistoryCases = self.orderedTuples(dict: self.countryHistory!.timeline.cases, completionHandler: self.processHistory)
        }
    }
        
    
    func getCountryHistory(country: Country, completionHandler: @escaping () -> Void) {
        self.country = country
        
        var query = country.countryName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if query == "", let iso3 = country.countryInfo.iso3 {
            query = iso3
        }
        
        let url = URL(string: "https://disease.sh/v2/historical/\(query)?lastdays=8")
        
        guard url != nil else {
            return
        }

        let session = URLSession.shared

        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if data != nil && error == nil {
                let decoder = JSONDecoder()
                do {
                    self.countryHistory = try decoder.decode(CountryHistory.self, from: data!)
                } catch {
                    print("Error parsing country history")
                }
                completionHandler()
            }
        }
        
        dataTask.resume()
    }
    
    func orderedTuples(dict: [String: Int], completionHandler: ([(Date, Int)]) -> [(Date, Int)])  -> [(Date, Int)] {
        var tupleArray = [(Date, Int)]()


            tupleArray = dict.map{$0}.map {
                guard let date = $0.0.toDate() else {
                    fatalError("could not convert string to date")
                }
                return (date, $0.1)
            }.sorted(by: {$0.0 < $1.0})


        return completionHandler(tupleArray)
    }
    

    func processHistory(array: [(Date, Int)]) -> [(Date, Int)] {
        var processedResult = [(Date, Int)]()
        guard array.count > 0 else { return processedResult }
        
        for index in 1...array.count - 1 {
            let new = array[index].1 - array[index - 1].1
            processedResult.append((array[index].0, new))
        }
    
        return processedResult
    }
}
