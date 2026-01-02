//
//  ToWatchView.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 31.12.25.
//
//  Displays the user's watchlist.
//  Anime that the user plans to watch in the future
//  are collected and managed here.

import SwiftUI

struct ToWatchView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("To Watch")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(Color.App.textPrimary)

                Text("Your watchlist lives here.")
                    .foregroundStyle(Color.App.textSecondary)

                Divider()
                    .overlay(Color.App.divider)

                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.App.surface)
                    .frame(height: 140)
                    .overlay(
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Watchlist")
                                .font(.headline)
                                .foregroundStyle(Color.App.textPrimary)
                            Text("Later: list management + sorting.")
                                .foregroundStyle(Color.App.textSecondary)
                        }
                        .padding(),
                        alignment: .topLeading
                    )

                Spacer()
            }
            .padding()
            .navigationTitle("To Watch")
        }
        .appTheme()
    }
}

#Preview {
    ToWatchView()
        .preferredColorScheme(.dark)
}

