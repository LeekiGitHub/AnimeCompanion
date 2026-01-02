//
//  AnimeCompanionApp.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 31.12.25.
//
//  App entry point.
//  Responsible for bootstrapping the application and
//  defining the root scene of the app.
//  Starts the app with AppRootView.

import SwiftUI

@main
struct AnimeCompanionApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .preferredColorScheme(.dark)
        }
    }
}
