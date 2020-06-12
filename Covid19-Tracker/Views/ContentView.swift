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
    
    var body: some View {
        ZStack {
            BackgroundImageView()

            VStack(spacing: 50) {
                HeaderTextView()
                
                GlobalSummaryView()
                
                Top5CardList()
                
                Spacer()
            }
        }
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
    var placeholderText: String = "loading..."
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
                if top5.count > 0 {
                    ForEach(0..<top5.count) { index in
                        Top5CardViewCell(rank: index+1,
                                         countryName: self.top5[index].countryName,
                                         countryNumbers: self.top5[index].numbersByPropertyName(name: self.property),
                                         countryFlag: getFlag(country: self.top5[index]))
                        if index != 4 {
                            FormattedDivider()
                        }
                    }
                } else {
                    Text("")
                        .frame(width: 0, height: 0)
                    ForEach(0..<5) { index in
                        Top5CardViewCell(rank: index+1,
                                         countryName: "loading...",
                                         countryNumbers: 0,
                                         countryFlag: "")
                        if index != 4 {
                            FormattedDivider()
                        }
                    }
                }
            }
            .padding(20)
        }
        .foregroundColor(Color.white)
        .frame(width:300, height: 300.0)
        .background(Color(red: 0.27, green: 0.27, blue: 0.27))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 20)
        .cornerRadius(20)
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

struct BackgroundImageView: View {
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("blob")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width)
            }
            .offset(y: -375)
        }
    }
}

struct HeaderTextView: View {
    @EnvironmentObject var api: Api
    @State var currentDateAndTime = Date()
    @State var spin = false
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Global Statistics 🌎")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Spacer()
            }
            HStack(alignment: .center) {
                Text("As of \(formatDate())")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Button(action: {
                    self.api.updateGlobal()
                    self.currentDateAndTime = Date()
                    self.spin.toggle()
                }, label: {
                    Image(systemName: "arrow.clockwise")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .rotationEffect(.degrees(spin ? 360 : 0))
                    .animation(.easeInOut(duration: 2))
                })
                    .foregroundColor(.white)
            }
        }
        .padding(20)
    }
    
    fileprivate func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        
        return formatter.string(from: self.currentDateAndTime)
    }
}

struct GlobalSummaryView: View {
    @EnvironmentObject var api: Api

    var body: some View {
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
    }
}

struct Top5CardList: View {
    @EnvironmentObject var api: Api

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 30){
                Top5CardView(cardTitle: "Countries with the Most Number of Cases", property: "cases", top5: $api.top5Cases)

                Top5CardView(cardTitle: "Countries with the Most Number of Deaths", property: "deaths", top5: $api.top5Deaths)

                Top5CardView(cardTitle: "Countries with the Most Number of Recovered", property: "recovered", top5: $api.top5Recovered)
            }
        }
        .frame(width: 385)
    }
}
