//
//  WatchedView.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 31.12.25.
//
//  Displays the list of anime the user has already completed.
//  Acts as a personal history/archive of watched titles.

import SwiftUI

struct WatchedView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Watched")
                    .font(.title2.weight(.semibold))

                Text("Completed anime will be archived here.")
                    .foregroundStyle(Color.App.textSecondary)

                Divider()
                    .overlay(Color.App.divider)

                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.App.surface)
                    .frame(height: 140)
                    .overlay(
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Watched Archive")
                                .font(.headline)
                            Text("Later: history, ratings, notes.")
                                .foregroundStyle(Color.App.textSecondary)
                        }
                        .padding(),
                        alignment: .topLeading
                    )

                Spacer()
            }
            .padding()
            .navigationTitle("Watched")
        }
        .appTheme()
    }
}

#Preview {
    WatchedView()
}

