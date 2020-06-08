//
//  SearchView.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-18.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var api: Api
    @State var searchText: String = ""
    
    var body: some View {

        NavigationView {
                List {
                    TextField("Search", text: $searchText)
                    Toggle(isOn: $userData.showFavoritesOnly) {
                        Text("Display only your favorites")
                    }
                    
                    ForEach(self.api.countries) { country in
                        if (!self.userData.showFavoritesOnly || country.isFavorite) && (country.countryName.uppercased().contains(self.searchText.uppercased()) || self.searchText.count == 0) {
                            NavigationLink(destination: CountryDetailView(country: country)) {
                                CountryRow(country: country)
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Browse Countries"))
        }
        .onAppear {
            UITableView.appearance().separatorStyle = .singleLine
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(Api()).environmentObject(UserData())
    }
}

struct CountryRow: View {
    var country: Country

    var body: some View {
        HStack {
            Text("\(country.countryName) \(getFlag(country: country))")
            Spacer()
            if country.isFavorite {
                Image(systemName: "bookmark.fill")
                    .imageScale(.medium)
                    .foregroundColor(Color(red: 1.00, green: 0.27, blue: 0.31))
            }
        }
    }
}

