//
//  CountryDetailView.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-08.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct CountryDetailView: View {
    @EnvironmentObject var api: Api
    @EnvironmentObject var userData: UserData
    @State var countryApi: CountryApi?

    var country: Country
    var countryIndex: Int {
        self.api.countries.firstIndex(where: {
            $0.id == country.id
        })!
    }
    
    init(country: Country) {
        self.country = country
    }
    
    var body: some View {
        VStack {
//            MapView(lat: country.countryInfo.lat, lon: country.countryInfo.long)
//                .frame(height: 300)
            HStack {
                Text("\(country.countryName)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.vertical)
                    .padding(.horizontal, 30)
                Spacer()
                Button(action: {
                    self.api.countries[self.countryIndex].isFavorite.toggle()
                }) {
                    if self.api.countries[self.countryIndex].isFavorite {
                        Image(systemName: "bookmark.fill")
                            .font(.title)
                            .foregroundColor(Color(red: 1.00, green: 0.27, blue: 0.31))
                    } else {
                        Image(systemName: "bookmark")
                            .font(.title)
                            .foregroundColor(Color(red: 1.00, green: 0.27, blue: 0.31))
                    }
                }
                    .padding(.trailing, 30)
            }
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("\(country.cases ?? 0)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.orange)
                        .fixedSize(horizontal: false, vertical: true)
                    Text("cases")
                        .font(.headline)
                }
                HStack {
                    Text("\(country.deaths ?? 0)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                    Text("deaths")
                        .font(.headline)
                }
                HStack {
                    Text("\(country.recovered ?? 0)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                    Text("recovered")
                        .font(.headline)
                }
            }
            ChartView()
        }
        .onAppear(perform: {
            self.countryApi = CountryApi(country: self.country)
        })
    }

}

struct CountryDetailView_Previews: PreviewProvider {

    static var previews: some View {
        CountryDetailView(country: testCountry).environmentObject(Api())
    }
}


var testCountry = Country(countryName: "testing", countryInfo: Country.CountryInfo(countryInfoID: nil, iso3: "test", lat: 34.011286, long: -116.166868, flag: "testflag"))

