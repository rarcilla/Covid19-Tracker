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
    private var baseUrlString = "https://disease.sh/v2/"
    var global: Global?
    var countries: [Country]?
    @Published var globalCases = 0
    @Published var globalDeaths = 0
    @Published var globalRecovered = 0
    @Published var top5Cases: [Country] = [Country]()
    @Published var top5Deaths: [Country] = [Country]()
    @Published var top5Recovered: [Country] = [Country]()
    
    init() {
        getGlobal {
            DispatchQueue.main.async {
                self.globalCases = self.global!.cases
                self.globalDeaths = self.global!.deaths
                self.globalRecovered = self.global!.recovered
            }
        }

        getAllCountries {
            DispatchQueue.main.async {
                self.getTop5Cases()
                self.getTop5Deaths()
                self.getTop5Recovered()
            }
        }
    
    }
    
    //get global summary
    func getGlobal(completionHandler: @escaping () -> Void){
        let url = URL(string: baseUrlString + "all")
        
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
        let url = URL(string: baseUrlString + "countries?yesterday=true")
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if data != nil && error == nil {
                let decoder = JSONDecoder()
                do {
                    self.countries = try decoder.decode([Country].self, from: data!)
//                    print(self.countries!.count)
                } catch {
                    print("error parsing country data: \(error)")
                }
                completionHandler()
            }
        }
        
        dataTask.resume()

    }


    func getTop5Cases() {
        let orderedCases = self.countries?.sorted(by: {$0.cases > $1.cases})
        self.top5Cases = Array((orderedCases?.prefix(5))!)
    }
    
    func getTop5Deaths() {
        let orderedDeaths = self.countries?.sorted(by: {$0.deaths > $1.deaths})
        self.top5Deaths = Array((orderedDeaths?.prefix(5))!)
    }
    
    func getTop5Recovered() {
        let orderedRecovered = self.countries?.sorted(by: {$0.recovered > $1.recovered})
        self.top5Recovered = Array((orderedRecovered?.prefix(5))!)
    }

}
