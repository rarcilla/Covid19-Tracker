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
                Text("The Latest on Covid-19 📰")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding()
            
            HStack {
                Spacer()
                List(api.articles) { article in
                    ArticleRow(article: article)
                        .padding(.bottom, 30)
                }
                Spacer()
            }
            .onAppear {
                UITableView.appearance().tableFooterView = UIView()
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().showsVerticalScrollIndicator = false
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView().environmentObject(Api())
    }
}

struct ArticleRow: View {
    var article: NewsFeed.Article
    
        @ViewBuilder var body: some View {
            if URL(string: self.article.urlToImage ?? "") != nil {
                ArticleWithImage(article: self.article)
            } else {
                ArticleNoImage(article: self.article)
            }
        }
}

struct ArticleWithImage: View {
    var article: NewsFeed.Article
    
    var body: some View {
        VStack() {
                URLImage(URL(string: self.article.urlToImage!)!, delay: 1) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(nil, contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            VStack(alignment: .leading, spacing: 10) {
                    Text("\(article.title ?? "Headline unavailable")")
                        .font(.headline)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 10)
                    Text("June 22, 2020")
                          .foregroundColor(.gray)
                          .font(.subheadline)
                          .padding(.leading, 10)
                    Text("\((article.description != nil) ? article.description!.truncate(maxLength: 200) : "Description Unavailable")")
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 10)
                    HStack {
                        Spacer()
                        Text("Source: \(article.source.name ?? "Unavailable")")
                            .font(.footnote)
                            .padding(.trailing, 10)
                    }
                }
                .padding(.vertical, 15)
            }
            .foregroundColor(Color.black)
            .background(Color.white)
            .frame(width: 360)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(radius: 10)
            .onTapGesture {
                if let articleURL = self.article.url {
                    let url: NSURL = URL(string: articleURL)! as NSURL
                    UIApplication.shared.open(url as URL)
                }
        }
    }
}

struct ArticleNoImage: View {
    var article: NewsFeed.Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(article.title ?? "Headline Unavailable")")
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 10)
            Text("June 22, 2020")
                .foregroundColor(.gray)
                .font(.subheadline)
                .padding(.leading, 10)
            Text("\((article.description != nil) ? article.description!.truncate(maxLength: 200) : "Description Unavailable")")
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 10)
            HStack {
                Spacer()
                Text("Source: \(article.source.name ?? "Unavailable")")
                    .font(.footnote)
                    .padding(.trailing, 10)
            }
            .padding(.top, 20)
        }
        .padding(.vertical, 15)
        .foregroundColor(Color.black)
        .background(Color.white)
        .frame(width: 360)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(radius: 10)
        .onTapGesture {
            if let articleURL = self.article.url {
                let url: NSURL = URL(string: articleURL)! as NSURL
                UIApplication.shared.open(url as URL)
            }
        }
    }
}


