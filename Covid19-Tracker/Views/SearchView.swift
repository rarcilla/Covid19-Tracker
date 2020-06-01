//
//  SearchView.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-18.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct SearchView: View {
//    var api: Api
    
    var body: some View {
        Text("hello")
//        return List(countries) { country in
//            CountryRow(country: country)
//        }
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
        Text("\(country.countryName)")
    }
}

