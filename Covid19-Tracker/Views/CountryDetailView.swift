//
//  CountryDetailView.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-08.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct CountryDetailView: View {
    @ObservedObject var api = Api()
    
    var body: some View {
        VStack {
            HStack {
                Text("Canada 🇨🇦")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.vertical)
                    .padding(.horizontal, 30)
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                    Text("1000")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.orange)
                    Text("cases")
                        .font(.headline)
                }
                Spacer()
                VStack {
                    Text("1000")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                    Text("deaths")
                        .font(.headline)
                }
                Spacer()
                VStack {
                    Text("1000")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                    Text("recovered")
                        .font(.headline)
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView()
    }
}


