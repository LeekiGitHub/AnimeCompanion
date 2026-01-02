//
//  MainTabView.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 31.12.25.
//
//  Main tab-based navigation container of the app.
//  Displays the bottom tab bar with the four primary
//  sections of the app: Search, Watching, Watched, To Watch.
//  Each tab owns its own NavigationStack.

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }

            WatchingView()
                .tabItem { Label("Watching", systemImage: "play.circle") }

            WatchedView()
                .tabItem { Label("Watched", systemImage: "checkmark.circle") }

            ToWatchView()
                .tabItem { Label("To Watch", systemImage: "bookmark") }
        }
        .tint(Color.App.accentPrimary)
        .toolbarBackground(Color.App.bgPrimary, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .background(Color.App.bgPrimary.ignoresSafeArea())
    }
}

#Preview {
    MainTabView()
        .preferredColorScheme(.dark)
}

