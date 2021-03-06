//
//  AppView.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-18.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @State var selected = 1
    
    var body: some View {
        TabView(selection: $selected) {
            SearchView()
                .tabItem {
                    selected == 0 ? Image(systemName: "magnifyingglass.circle.fill") : Image(systemName:"magnifyingglass.circle")
                    Text("Search")
            }
            .tag(0)
            
            ContentView()
                .tabItem {
                    selected == 1 ? Image(systemName: "house.fill") : Image(systemName:"house")
                    Text("Home")
            }
            .tag(1)
            
            
            NewsView()
                .tabItem {
                    selected == 2 ? Image(systemName: "book.fill") : Image(systemName:"book")
                    Text("News")
            }
            .tag(2)
            
        }
        .accentColor(Color(red: 1.00, green: 0.27, blue: 0.31))
    }
}

//struct AppView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppView().environmentObject(Api()).environmentObject(UserData())
//    }
//}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
