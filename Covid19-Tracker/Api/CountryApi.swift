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
    var country: Country
    var countryHistory: CountryHistory?
    @Published var countryHistoryCases: [String: Int] = [:]
    
    init(country: Country) {
        self.country = country
        self.getCountryHistory(country: country) {
            DispatchQueue.main.async {
                print("print country history of \(country): \(self.countryHistory)")
            }
        }
    }
        
    
    func getCountryHistory(country: Country, completionHandler: @escaping () -> Void) {
        var query = country.countryName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if query == "", let iso3 = country.countryInfo.iso3 {
            query = iso3
        }
        
        print("this is the query: \(query)")

        let url = URL(string: "https://disease.sh/v2/historical/\(query)?lastdays=7")
        
        guard url != nil else {
            return
        }

        let session = URLSession.shared

        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if data != nil && error == nil {
                let decoder = JSONDecoder()
                do {
                    print("before decoding")
                    self.countryHistory = try decoder.decode(CountryHistory.self, from: data!)
                    print("after decoding")
                } catch {
                    print("Error parsing country history")
                }
                print("here before completion")
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

        for index in 0...array.count - 1 {
            if index == 0 {
                processedResult.append((array[index].0, array[index].1))
            } else {
                let new = array[index].1 - array[index - 1].1
                processedResult.append((array[index].0, new))
            }
        }
        return processedResult
    }
}
