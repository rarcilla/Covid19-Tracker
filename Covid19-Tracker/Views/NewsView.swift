//
//  NewsView.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-06-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var api: Api
    var body: some View {
        VStack {
            HStack {
                Text("Covid-19 Articles 📰")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding()
            .padding(.bottom, 10)
            
            List(api.articles) { article in
                Text("\(article.title!)")
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
