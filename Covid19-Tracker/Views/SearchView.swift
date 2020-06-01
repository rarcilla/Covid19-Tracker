//
//  SearchView.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-18.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var api: Api
    
    var body: some View {
        NavigationView {
            List(api.countries, rowContent: CountryRow.init)
            .navigationBarTitle(Text("Browse Countries"))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct CountryRow: View {
    var country: Country

    var body: some View {
        Text("\(country.countryName) \(getFlag(country: country))")
    }
}

