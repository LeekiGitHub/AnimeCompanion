//
//  AppRootView.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 31.12.25.
//
//  Root view of the application.
//  Decides which high-level flow is shown (e.g. login flow
//  vs. main application).
//  Currently always shows MainTabView.
//  Authentication logic will be added here later.

import SwiftUI

struct AppRootView: View {
    var body: some View {
        MainTabView()
    }
}

#Preview {
    AppRootView()
}
