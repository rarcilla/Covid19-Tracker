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
    @Published var countries = [Country]()
    var newsFeed: NewsFeed?
    @Published var articles = [NewsFeed.Article]()
//    var globalHistory: [String: [String:Int]]?
    
    @Published var globalCases = 0
    @Published var globalDeaths = 0
    @Published var globalRecovered = 0
    
    @Published var globalTodayCases = 0
    @Published var globalTodayDeaths = 0
    
    
    @Published var top5Cases: [Country] = [Country]()
    @Published var top5Deaths: [Country] = [Country]()
    @Published var top5Recovered: [Country] = [Country]()
    
    init() {
        updateGlobal()
        
        updateCountries()
        
        updateNewsArticles()
    }
    
    func updateGlobal(){
        getGlobal {
            DispatchQueue.main.async {
                self.globalCases = self.global!.cases
                self.globalDeaths = self.global!.deaths
                self.globalRecovered = self.global!.recovered
                
                self.globalTodayCases = self.global!.todayCases
                self.globalTodayDeaths = self.global!.todayDeaths
            }
        }
    }
        
    
    func updateCountries() {
        getAllCountries {
            DispatchQueue.main.async {
                self.getTop5Cases()
                self.getTop5Deaths()
                self.getTop5Recovered()
            }
        }
    }
    
    func updateNewsArticles() {
        getNewsArticles {
            DispatchQueue.main.async {
                self.articles = self.newsFeed?.articles ?? []
            }
        }
    }
    
//        getGlobalHistory(numberOfDays: 7) {
//            DispatchQueue.main.async {
//                self.globalHistoryCases = self.tuplesOrderedByDate(dict: self.globalHistory!["cases"], completionHandler: self.processHistory)
//            }
//        }
        
    
        
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
                   let countries = try decoder.decode([Country].self, from: data!)
                    DispatchQueue.main.async {
                        self.countries = countries
                    }
                } catch {
                    print("error parsing country data: \(error)")
                }
                completionHandler()
            }
        }
        
        dataTask.resume()
    }

//    func getGlobalHistory(numberOfDays: Int, completionHandler: @escaping () -> Void) {
//        let url = URL(string: baseUrlStr + "historical/all?lastdays=\(numberOfDays)")
//
//        guard url != nil else {
//            return
//        }
//
//        let session = URLSession.shared
//
//        let dataTask = session.dataTask(with: url!) { (data, response, error) in
//            if data != nil && error == nil {
//
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: [String:Int]] {
//                        self.globalHistory = json
//                    }
//                } catch {
//                    print("Error parsing global history")
//                }
//                completionHandler()
//            }
//        }
//
//        dataTask.resume()
//    }
    
    func getTop5Cases() {
        let orderedCases = self.countries.sorted(by: {$0.cases ?? 0 > $1.cases ?? 0})
        guard orderedCases.count > 0 else { fatalError("countries array is empty")}
        self.top5Cases = Array((orderedCases.prefix(5)))
    }
    
    func getTop5Deaths() {
        let orderedDeaths = self.countries.sorted(by: {$0.deaths ?? 0 > $1.deaths ?? 0})
        guard orderedDeaths.count > 0 else { fatalError("countries array is empty")}
        self.top5Deaths = Array((orderedDeaths.prefix(5)))
    }
    
    func getTop5Recovered() {
        let orderedRecovered = self.countries.sorted(by: {$0.recovered ?? 0 > $1.recovered ?? 0})
        guard orderedRecovered.count > 0 else { fatalError("countries array is empty")}
        self.top5Recovered = Array((orderedRecovered.prefix(5)))
    }
    
    //precondition: tuples are ordered according to date
    func processHistory(array: [(String, Int)]) -> [(String, Double)] {
        var processedResult = [(String, Double)]()
        guard array.count > 0 else { return processedResult }
        
        for index in 0...array.count - 1 {
            if index == 0 {
                processedResult.append((array[index].0, Double(array[index].1)))
            } else {
                let new = Double(array[index].1 - array[index - 1].1)
                processedResult.append((array[index].0, new))
            }
        }
        return processedResult
    }
    
    func getNewsArticles(completionHandler: @escaping () -> Void) {
        let query = "+covid-19 OR +coronavirus".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "covid-19"
        let urlStr = "https://newsapi.org/v2/everything?qInTitle=\(query)&language=en&sortBy=publishedAt&apiKey=\(newsApiKey)"
        
        let url = URL(string: urlStr)
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do {
                    self.newsFeed = try decoder.decode(NewsFeed.self, from: data!)
                } catch {
                    fatalError("error: failed to parse news articles")
                }
                completionHandler()
            }
        })
        
        dataTask.resume()
    }
}
