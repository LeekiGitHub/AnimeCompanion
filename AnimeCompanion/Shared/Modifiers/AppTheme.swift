//
//  AppTheme.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 01.01.26.
//

import SwiftUI

extension View {
    /// Applies the app's default background and primary text color.
    /// Use this on screen roots (typically on NavigationStack content).
    func appTheme() -> some View {
        self
            .foregroundStyle(Color.App.textPrimary)
            .background(Color.App.bgPrimary.ignoresSafeArea())
            .toolbarBackground(Color.App.bgPrimary, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
