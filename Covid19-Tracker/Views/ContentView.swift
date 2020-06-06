//
//  ContentView.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var api: Api
    @State var currentDateAndTime = Date()
    
    var body: some View {
        ZStack {
            VStack {
                Image("blob")
                    .offset(y: -330)
                Spacer()
            }
            
            VStack(spacing: 50) {
                VStack {
                    HStack {
                        Text("Global Statistics 🌎")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    HStack {
                        Text("As of \(formatDate())")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 5)
                            .padding(.bottom, 15.0)
                        Spacer()
                    }
                }
                .padding(.top, 80)
                
                VStack {
                    HStack {
                        Text("\(api.globalCases) Cases")
                            .foregroundColor(.black)
                        Text("+\(api.globalTodayCases)")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.green)
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("\(api.globalDeaths) Deaths")
                            .foregroundColor(.black)
                        Text("+\(api.globalTodayDeaths)")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.green)
                        
                    }
                    .padding(.bottom, 5)
                    
                    Text("\(api.globalRecovered) Recovered")
                        .foregroundColor(.black)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20)
                
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
                Spacer()
            }
            .frame(width: 360)
        }
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
        ContentView().environmentObject(Api())
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
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            VStack {
                Top5CardViewCell(rank: 1, countryName: top5.count > 0 ? top5[0].countryName : "loading...",
                                 countryNumbers: top5.count > 0 ? top5[0].numbersByPropertyName(name: property) : 0,
                                 countryFlag: top5.count > 0 ? getFlag(country: top5[0]) : "")
                
                FormattedDivider()
                
                Top5CardViewCell(rank: 2, countryName: top5.count > 0 ? top5[1].countryName : "loading...",
                                 countryNumbers: top5.count > 0 ? top5[1].numbersByPropertyName(name: property) : 0,
                                 countryFlag: top5.count > 0 ? getFlag(country: top5[1]) : "")
                
                FormattedDivider()
                
                Top5CardViewCell(rank: 3, countryName: top5.count > 0 ? top5[2].countryName : "loading...",
                                 countryNumbers: top5.count > 0 ? top5[2].numbersByPropertyName(name: property) : 0,
                                 countryFlag: top5.count > 0 ? getFlag(country: top5[2]) : "")
                
                FormattedDivider()
                
                Top5CardViewCell(rank: 4, countryName: top5.count > 0 ? top5[3].countryName : "loading...",
                                 countryNumbers: top5.count > 0 ? top5[3].numbersByPropertyName(name: property) : 0,
                                 countryFlag: top5.count > 0 ? getFlag(country: top5[3]) : "")
                
                FormattedDivider()
                
                Top5CardViewCell(rank: 5, countryName: top5.count > 0 ? top5[4].countryName : "loading...",
                                 countryNumbers: top5.count > 0 ? top5[4].numbersByPropertyName(name: property) : 0,
                                 countryFlag: top5.count > 0 ? getFlag(country: top5[4]) : "")
            }
            .padding(20)
        }
        .foregroundColor(Color.white)
        .frame(width:300, height: 300.0)
        .background(Color(red: 0.27, green: 0.27, blue: 0.27))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(radius: 10)
    }
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



