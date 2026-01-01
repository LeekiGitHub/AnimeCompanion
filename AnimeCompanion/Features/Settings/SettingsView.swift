//
//  SettingsView.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 31.12.25.
//
//  Application settings screen.
//  Allows the user to configure preferences such as
//  appearance, notifications and account-related options.

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Settings")
                    .font(.title2.weight(.semibold))

                Text("Preferences and app configuration.")
                    .foregroundStyle(Color.App.textSecondary)

                Divider()
                    .overlay(Color.App.divider)

                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.App.surface)
                    .frame(height: 140)
                    .overlay(
                        Text("Settings Placeholder")
                            .padding(),
                        alignment: .topLeading
                    )

                Spacer()
            }
            .padding()
            .navigationTitle("Settings")
        }
        .appTheme()
    }
}

#Preview {
    SettingsView()
}
