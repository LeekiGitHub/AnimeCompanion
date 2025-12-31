//
//  MainTabView.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 31.12.25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            WatchingView()
                .tabItem {
                    Label("Watching", systemImage: "play.circle")
                }

            WatchedView()
                .tabItem {
                    Label("Watched", systemImage: "checkmark.circle")
                }

            ToWatchView()
                .tabItem {
                    Label("To Watch", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    MainTabView()
}
