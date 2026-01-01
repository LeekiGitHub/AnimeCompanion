//
//  SearchView.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 31.12.25.
//
//  Search screen of the app.
//  Allows users to search for anime and discover new titles.
//  This is the default start screen after app launch.

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Search")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(Color.App.textPrimary)

                Text("Start building your search UI here.")
                    .foregroundStyle(Color.App.textSecondary)

                Divider()
                    .overlay(Color.App.divider)

                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.App.surface)
                    .frame(height: 140)
                    .overlay(
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Surface Card")
                                .font(.headline)
                                .foregroundStyle(Color.App.textPrimary)
                            Text("This is a placeholder card using `surface`.")
                                .foregroundStyle(Color.App.textSecondary)
                        }
                        .padding(),
                        alignment: .topLeading
                    )

                Spacer()
            }
            .padding()
            .navigationTitle("Search")
        }
        .appTheme()
    }
}

#Preview {
    SearchView()
}

