//
//  SplashScreen.swift
//  StocksViewer
//
//  Created by Анас Бен Мустафа on 3/18/21.
//

import SwiftUI

/**
 Стартовый экран с TabView
 */
struct SplashScreenView: View {
    
    @EnvironmentObject var stocksData: StockData
    
    init() {
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = UIColor(Color.black.opacity(0.875))
    }
    
    var body: some View {
        TabView {
            MainView().environmentObject(stocksData)
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Обзор")
                }
            
            NewsView()
                .tabItem {
                    Image(systemName: "note.text")
                    Text("Новости")
                }
        }
    }
}
