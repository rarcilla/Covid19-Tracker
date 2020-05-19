//
//  Api.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import Foundation
import Combine

class Api: ObservableObject {
    private var baseUrlStr = "https://disease.sh/v2/"
    var global: Global?
    var countries: [Country]?
    var globalHistory7: [String: [String:Int]]?
    @Published var globalCases = 0
    @Published var globalDeaths = 0
    @Published var globalRecovered = 0
    
    @Published var globalTodayCases = 0
    @Published var globalTodayDeaths = 0
    
    
    @Published var top5Cases: [Country] = [Country]()
    @Published var top5Deaths: [Country] = [Country]()
    @Published var top5Recovered: [Country] = [Country]()
    
    @Published var globalHistory7Cases: [(String, Int)] = []
    @Published var globalHistory7Deaths: [(String, Int)] = []
    @Published var globalHistory7Recovered: [(String, Int)] = []
        
    init() {
        getGlobal {
            DispatchQueue.main.async {
                self.globalCases = self.global!.cases
                self.globalDeaths = self.global!.deaths
                self.globalRecovered = self.global!.recovered
                
                self.globalTodayCases = self.global!.todayCases
                self.globalTodayDeaths = self.global!.todayDeaths
            }
        }

        getAllCountries {
            DispatchQueue.main.async {
                self.getTop5Cases()
                self.getTop5Deaths()
                self.getTop5Recovered()
            }
        }
        
        getGlobalHistoryLast7Days {
            print("finished history function")
            print(self.globalHistory7!)
            DispatchQueue.main.async {
//                print("1: \(self.tuplesOrderedByDate(dict: self.globalHistory7!["cases"]))")
                self.globalHistory7Cases = self.processHistory(array: self.tuplesOrderedByDate(dict: self.globalHistory7!["cases"]))
//                print("2: \( self.globalHistory7Cases)")

                self.globalHistory7Deaths = self.processHistory(array: self.tuplesOrderedByDate(dict: self.globalHistory7!["deaths"]))
                self.globalHistory7Recovered = self.processHistory(array: self.tuplesOrderedByDate(dict: self.globalHistory7!["recovered"]))
                
//                self.globalHistory7Deaths = self.tuplesOrderedByDate(dict: self.globalHistory7!["deaths"])
//                self.globalHistory7Recovered = self.tuplesOrderedByDate(dict: self.globalHistory7!["recovered"])
//                print("hello: \( self.globalHistory7Cases.map {Double($0.1)})")
//                print("hello: \( self.globalHistory7Cases)")
            }
        }
        

    }
    
    func tuplesOrderedByDate(dict: [String: Int]?) -> [(String, Int)] {
        var tupleArray = [(String, Int)]()
        
        if let dict = dict {
            tupleArray = dict.map{$0}.sorted {
                guard let date1 = toDate(str: $0.0), let date2 = toDate(str: $1.0) else {
                    return false
                }
                return date1 < date2
            }
        }
        
        return tupleArray
    }
    
    //get global summary
    func getGlobal(completionHandler: @escaping () -> Void){
        let url = URL(string: baseUrlStr + "all")
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared

        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if data != nil && error == nil {
                let decoder = JSONDecoder()
                do {
                    self.global = try decoder.decode(Global.self, from: data!)
                } catch {
                    print("error parsing global data: \(error)")
                }
                completionHandler()
            }
        }
        dataTask.resume()
    }

    func getAllCountries(completionHandler: @escaping () -> Void){
        let url = URL(string: baseUrlStr + "countries?yesterday=true")
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if data != nil && error == nil {
                let decoder = JSONDecoder()
                do {
                    self.countries = try decoder.decode([Country].self, from: data!)
                } catch {
                    print("error parsing country data: \(error)")
                }
                completionHandler()
            }
        }
        
        dataTask.resume()

    }

    func getGlobalHistoryLast7Days(completionHandler: @escaping () -> Void) {
        let url = URL(string: baseUrlStr + "historical/all?lastdays=all")
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if data != nil && error == nil {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: [String:Int]] {
                        self.globalHistory7 = json
                    }
                } catch {
                    print("Error parsing history")
                }
                completionHandler()
            }
        }
        
        dataTask.resume()
        
    }
    
    func getTop5Cases() {
        let orderedCases = self.countries?.sorted(by: {$0.cases ?? 0 > $1.cases ?? 0})
        self.top5Cases = Array((orderedCases?.prefix(5))!)
    }
    
    func getTop5Deaths() {
        let orderedDeaths = self.countries?.sorted(by: {$0.deaths ?? 0 > $1.deaths ?? 0})
        self.top5Deaths = Array((orderedDeaths?.prefix(5))!)
    }
    
    func getTop5Recovered() {
        let orderedRecovered = self.countries?.sorted(by: {$0.recovered ?? 0 > $1.recovered ?? 0})
        self.top5Recovered = Array((orderedRecovered?.prefix(5))!)
    }
    
    //precondition: tuples are organized by date
    func processHistory(array: [(String, Int)]) -> [(String, Int)] {
        var processedResult = [(String, Int)]()
        guard globalHistory7!.count > 0 else { return processedResult }
        
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

extension Api {
    func toDate(str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        
        guard let date = dateFormatter.date(from: str) else {
            return nil
        }
        
        return date
    }
}

