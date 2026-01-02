//
//  ProfileView.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 31.12.25.
//
//  Displays user profile information.
//  Includes personal data, statistics and future
//  gamification-related features.

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Profile")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(Color.App.textPrimary)

                Text("User info, stats, gamification later.")
                    .foregroundStyle(Color.App.textSecondary)

                Divider()
                    .overlay(Color.App.divider)

                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.App.surface)
                    .frame(height: 140)
                    .overlay(
                        Text("Profile Placeholder")
                            .foregroundStyle(Color.App.textPrimary)
                            .padding(),
                        alignment: .topLeading
                    )

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
        .appTheme()
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
