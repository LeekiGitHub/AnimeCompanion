//
//  WatchingView.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 31.12.25.
//
//  Displays the list of anime the user is currently watching.
//  Users can track progress and navigate to detail views
//  from this screen.

import SwiftUI

struct WatchingView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Watching")
                    .font(.title2.weight(.semibold))

                Text("Anime you're currently watching will appear here.")
                    .foregroundStyle(Color.App.textSecondary)

                Divider()
                    .overlay(Color.App.divider)

                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.App.surface)
                    .frame(height: 140)
                    .overlay(
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Currently Watching")
                                .font(.headline)
                            Text("Later: list + progress tracking.")
                                .foregroundStyle(Color.App.textSecondary)
                        }
                        .padding(),
                        alignment: .topLeading
                    )

                Spacer()
            }
            .padding()
            .navigationTitle("Watching")
        }
        .appTheme()
    }
}

#Preview {
    WatchingView()
}

