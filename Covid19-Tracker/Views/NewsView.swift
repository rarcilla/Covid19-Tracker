//
//  NewsView.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-06-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI
import URLImage

struct NewsView: View {
    @EnvironmentObject var api: Api
    var body: some View {
        VStack {
            HStack {
                Text("Latest Covid-19 Articles 📰")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding()
            .padding(.bottom, 10)
            
            List(api.articles) { article in
                ArticleRow(article: article)
            }
            .onAppear {
                UITableView.appearance().tableFooterView = UIView()
                UITableView.appearance().separatorStyle = .none
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

struct ArticleRow: View {
    var article: NewsFeed.Article
    
    var body: some View {
        VStack {
            if URL(string: self.article.urlToImage ?? "") != nil {
                URLImage(URL(string: self.article.urlToImage!)!)
            }
            Text("\(article.title ?? "Headline unavailable")")
                .font(.headline)
            Text("\(article.publishedAt ?? "Headline unavailable")")
            .font(.subheadline)
            Text("\(article.description ?? "Description unavailable")")
            HStack {
                Text("\(article.source.name ?? "Source unavailable")")
                Spacer()
                Text("\(article.author ?? "Author unavailable")")
            }
            .font(.footnote)
        }
        .background(Color.blue)
        .onTapGesture {
            if let articleURL = self.article.url {
                let url: NSURL = URL(string: articleURL)! as NSURL
                UIApplication.shared.open(url as URL)
            }
        }
    }
}
