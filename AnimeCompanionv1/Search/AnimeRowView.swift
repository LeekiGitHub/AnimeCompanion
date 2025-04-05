//
//  AnimeRowView.swift
//  AnimeCompanionv1
//
//  Created by Yannik Leekes on 02.04.25.
//


import SwiftUI

struct AnimeRowView: View {
    let anime: Anime

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Titel + "Watch Later"-Tag
            HStack {
                Text(anime.title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("Watch Later")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(Capsule())
            }

            // Bewertung mit Sternen
            HStack(spacing: 4) {
                ForEach(0..<5) { index in
                    Image(systemName: index < Int((anime.score ?? 0) / 2) ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color("sakuraPink"))
                }

                Text(String(format: "%.1f", anime.score ?? 0))
                    .foregroundColor(.gray)
                    .font(.caption)
            }

            // Genres
            HStack {
                ForEach(anime.genres.prefix(3), id: \.self) { genre in
                    Text(genre.name)
                        .font(.caption)
                        .foregroundColor(.black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color("sakuraPink"))
                        .clipShape(Capsule())
                }
            }

            // Infos: Episoden, Status, Jahr
            HStack(spacing: 16) {
                Text("\(anime.episodes ?? 0) Episodes")
                Text(anime.status ?? "Unknown")
                Text("\(anime.year ?? 0)")
            }
            .foregroundColor(.gray)
            .font(.caption)

            // Buttons
            HStack {
                Button(action: {}) {
                    Label("Info", systemImage: "info.circle")
                }
                .buttonStyle(.bordered)
                .tint(Color("sakuraPink"))

                Button(action: {}) {
                    Label("Watch Later", systemImage: "clock")
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("sakuraPink"))

                Button(action: {}) {
                    Label("Watched", systemImage: "eye")
                }
                .buttonStyle(.bordered)
                .tint(Color("sakuraPink"))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("sakuraPink"), lineWidth: 1)
        )
        .padding(.vertical, 4)
    }
}
