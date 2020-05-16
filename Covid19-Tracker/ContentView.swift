//
//  ContentView.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var api = Api()
    @State var currentDateAndTime = Date()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Covid19 Tracker")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                }
                .padding(.top, 20)
                
                ScrollView() {
                    VStack(spacing: 50) {
                        VStack {
                            Text("Global Statistics")
                                .font(.title)
                                .foregroundColor(Color(red: 1.00, green: 0.27, blue: 0.31))
                            Text(formatDate())
                                .font(.headline)
                                .foregroundColor(Color(red: 0.36, green: 0.36, blue: 0.36))
                                .padding(.bottom, 10.0)
                            Text("\(api.globalCases) Cases")
                            Text("\(api.globalDeaths) Deaths")
                            Text("\(api.globalRecovered) Recovered")
                        }
                
                        ScrollView(.horizontal) {
                            HStack(spacing: 30){
                                Top5CardView(cardTitle: "Countries with the Most Number of Cases", property: "cases", top5: $api.top5Cases)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                Top5CardView(cardTitle: "Countries with the Most Number of Deaths", property: "deaths", top5: $api.top5Deaths)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                Top5CardView(cardTitle: "Countries with the Most Number of Recovered", property: "recovered", top5: $api.top5Recovered)
                                    .background(Color.white)
                                    .cornerRadius(20)
                            }
                        }
                        .frame(width: 360)
                        
                        VStack(spacing: 15) {
                            HStack {
                                ContinentCardView(continentName: "Favorites")
                                Spacer()
                                ContinentCardView(continentName: "North America")
                            }
                            
                            HStack {
                                ContinentCardView(continentName: "South America")
                                Spacer()
                                ContinentCardView(continentName: "Africa")
                            }
                            
                            HStack {
                                ContinentCardView(continentName: "Asia")
                                Spacer()
                                ContinentCardView(continentName: "Europe")
                            }
                            
                            HStack {
                                ContinentCardView(continentName: "Australia")
                                Spacer()
                                ContinentCardView(continentName: "Antarctica")
                            }
                        }
                        .frame(width: 360)
                    }
                }
            }
        }
        .background(Color(red: 0.98, green: 0.98, blue: 0.98).edgesIgnoringSafeArea(.all))
    }
 
    fileprivate func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        
        return formatter.string(from: self.currentDateAndTime)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContinentCardView: View {
    var continentName: String
    
    var body: some View {
        VStack {
            Text(self.continentName)
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
        }
        .frame(width: 170, height: 180)
        .background(Color(red: 1.00, green: 0.27, blue: 0.31))
        .cornerRadius(20)
//        .shadow(radius: 5)
    }
}

struct Top5CardView: View {
    var cardTitle: String
    var property: String
    @Binding var top5: [Country]
    
    var body: some View {
        VStack {
            HStack {
                Text(self.cardTitle)
                    .font(.headline)
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            VStack {
                Top5CardViewCell(rank: 1, countryName: top5.count > 0 ? top5[0].country : "loading...",
                                 countryNumbers: top5.count > 0 ? top5[0].numbersByPropertyName(name: property) : 0,
                                 countryFlag: top5.count > 0 ? getFlag(country: top5[0]) : "")
                
                FormattedDivider()
                
                Top5CardViewCell(rank: 2, countryName: top5.count > 0 ? top5[1].country : "loading...",
                                 countryNumbers: top5.count > 0 ? top5[1].numbersByPropertyName(name: property) : 0,
                                 countryFlag: top5.count > 0 ? getFlag(country: top5[1]) : "")
                
                FormattedDivider()
                
                Top5CardViewCell(rank: 3, countryName: top5.count > 0 ? top5[2].country : "loading...",
                                 countryNumbers: top5.count > 0 ? top5[2].numbersByPropertyName(name: property) : 0,
                                 countryFlag: top5.count > 0 ? getFlag(country: top5[2]) : "")
                
                FormattedDivider()
                
                Top5CardViewCell(rank: 4, countryName: top5.count > 0 ? top5[3].country : "loading...",
                                 countryNumbers: top5.count > 0 ? top5[3].numbersByPropertyName(name: property) : 0,
                                 countryFlag: top5.count > 0 ? getFlag(country: top5[3]) : "")
                
                FormattedDivider()
                
                Top5CardViewCell(rank: 5, countryName: top5.count > 0 ? top5[4].country : "loading...",
                                 countryNumbers: top5.count > 0 ? top5[4].numbersByPropertyName(name: property) : 0,
                                 countryFlag: top5.count > 0 ? getFlag(country: top5[4]) : "")
            }
            .padding(20)
        }
        .foregroundColor(Color.white)
        .frame(width:300, height: 300.0)
        .background(Color(red: 0.27, green: 0.27, blue: 0.27))
        .cornerRadius(20)
    }
}

    fileprivate func getFlag(country: Country) -> String {
        var flag = ""
        if let iso3 = country.countryInfo.iso3 {
            flag = IsoCountryCodes.find(key: iso3)?.flag ?? ""
        }
        return flag
}

struct FormattedDivider: View {
    var body: some View {
        VStack {
            Divider()
                .frame(height: 1)
                .background(Color.white)
                .opacity(0.3)
        }
    }
}

struct Top5CardViewCell: View {
    var rank: Int
    var countryName: String
    var countryNumbers: Int
    var countryFlag: String
    
    var body: some View {
        HStack {
            Text(String(self.rank))
                .fontWeight(.bold)
            Text("\(self.countryName) \(self.countryFlag)")
            Spacer()
            Text("\(self.countryNumbers)")
        }
    }
}
