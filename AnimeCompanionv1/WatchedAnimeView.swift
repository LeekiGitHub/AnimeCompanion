//
//  WatchedAnimeView.swift
//  AnimeCompanionv1
//
//  Created by Yannik Leekes on 02.04.25.
//


import SwiftUI

struct WatchedAnimeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedSortOption = "Name"
    
    let sortOptions = ["Name", "Rating", "Zuletzt geschaut"]

    var body: some View {
        VStack(spacing: 16) {
            // HEADER
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(Color("sakuraPink"))
                }

                Text("Watched Anime")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("sakuraPink"))

                Spacer()
                
                Menu {
                    ForEach(sortOptions, id: \.self) { option in
                        Button(action: {
                            selectedSortOption = option
                        }) {
                            Text(option)
                                
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text("Sort by")
                        Image(systemName: "chevron.down")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("sakuraPink"), lineWidth: 1)
                    )
                }
                .foregroundColor(Color("sakuraPink"))
            }
            .padding(.horizontal)
            .padding(.top)

            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    WatchedAnimeView()
}
