//
//  AnimeCard.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 01.01.26.
//
//  Wiederverwendbare Komponente für die Anzeige eines Animes.
//  Diese Card kann in verschiedenen Kontexten verwendet werden:
//  - In der Suchliste
//  - In der Watching-Liste
//  - In der Watched-Liste
//  - In der To Watch-Liste
//
//  Die Card zeigt die wichtigsten Informationen an und hat
//  optionale Action-Buttons (Watching, To Watch, Watched).

import SwiftUI

/// Stil-Variante der AnimeCard
/// Enum definiert verschiedene Optionen
enum AnimeCardStyle {
    /// Kompakter Stil für Listen (weniger Details)
    case compact
    /// Detaillierter Stil (mehr Informationen)
    case detailed
}

/// Wiederverwendbare Card-Komponente für die Anzeige eines Animes
struct AnimeCard: View {
    // MARK: - Eigenschaften
    
    /// Das Anime, das angezeigt werden soll
    let anime: Anime
    
    /// Der Stil der Card (compact oder detailed)
    var style: AnimeCardStyle = .compact
    
    /// Ob die Action-Buttons angezeigt werden sollen
    /// In manchen Views (z.B. Watched-Liste) brauchen wir vielleicht keine Buttons
    var showActionButtons: Bool = true
    
    /// Callback-Funktionen für die Action-Buttons
    /// @escaping bedeutet, dass die Funktion später aufgerufen werden kann
    /// Optional (?) bedeutet, dass die Funktion nicht vorhanden sein muss
    var onWatchingTap: (() -> Void)? = nil
    var onToWatchTap: (() -> Void)? = nil
    var onWatchedTap: (() -> Void)? = nil
    
    // MARK: - Body (Die UI wird hier definiert)
    
    var body: some View {
        // HStack = Horizontal Stack (Elemente nebeneinander)
        HStack(alignment: .top, spacing: 12) {
            // MARK: - Bild-Bereich (links)
            
            // Placeholder für das Bild
            // Später können wir hier ein echtes Bild laden
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.App.surface)
                .frame(width: 80, height: 120)
                .overlay(
                    // Placeholder-Icon, wenn kein Bild vorhanden ist
                    Image(systemName: "photo")
                        .foregroundStyle(Color.App.textSecondary)
                        .font(.title2)
                )
            
            // MARK: - Info-Bereich (rechts)
            
            // VStack = Vertical Stack (Elemente untereinander)
            VStack(alignment: .leading, spacing: 8) {
                // Titel des Animes
                Text(anime.displayTitle)
                    .font(.headline)
                    .foregroundStyle(Color.App.textPrimary)
                    .lineLimit(2) // Maximal 2 Zeilen
                
                // Alternativer Titel (falls vorhanden)
                if let alternativeTitle = anime.alternativeTitle {
                    Text(alternativeTitle)
                        .font(.subheadline)
                        .foregroundStyle(Color.App.textSecondary)
                        .lineLimit(1)
                }
                
                // Genres als Chips
                // HStack für die Genres nebeneinander
                if !anime.genres.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            // ForEach durchläuft alle Genres
                            ForEach(anime.genres.prefix(3), id: \.self) { genre in
                                // Genre-Chip
                                Text(genre)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.App.surface)
                                    .foregroundStyle(Color.App.textSecondary)
                                    .cornerRadius(4)
                            }
                        }
                    }
                }
                
                // Episoden und Format-Info
                HStack(spacing: 12) {
                    // Episoden-Anzahl
                    if let episodes = anime.episodes {
                        Label("\(episodes) Ep.", systemImage: "tv")
                            .font(.caption)
                            .foregroundStyle(Color.App.textSecondary)
                    }
                    
                    // Format (TV, Movie, etc.)
                    if let format = anime.format {
                        Text(format)
                            .font(.caption)
                            .foregroundStyle(Color.App.textSecondary)
                    }
                }
                
                // MARK: - Action-Buttons (nur wenn showActionButtons true ist)
                
                if showActionButtons {
                    HStack(spacing: 8) {
                        // Watching-Button
                        Button(action: {
                            // Ruft die Callback-Funktion auf, falls vorhanden
                            onWatchingTap?()
                        }) {
                            Image(systemName: "play.circle.fill")
                                .font(.title3)
                                .foregroundStyle(Color.App.accentPrimary)
                        }
                        
                        // To Watch-Button
                        Button(action: {
                            onToWatchTap?()
                        }) {
                            Image(systemName: "bookmark.fill")
                                .font(.title3)
                                .foregroundStyle(Color.App.accentSecondary)
                        }
                        
                        // Watched-Button
                        Button(action: {
                            onWatchedTap?()
                        }) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title3)
                                .foregroundStyle(Color.App.accentPrimary.opacity(0.7))
                        }
                    }
                    .padding(.top, 4)
                }
            }
            
            // Spacer schiebt alles nach links
            Spacer()
        }
        .padding(12)
        .background(Color.App.surface)
        .cornerRadius(12)
    }
}

// MARK: - Preview
#Preview {
    // VStack für mehrere Cards in der Preview
    VStack(spacing: 12) {
        // Beispiel-Card mit allen Buttons
        AnimeCard(
            anime: Anime.example1,
            showActionButtons: true,
            onWatchingTap: { print("Watching tapped") },
            onToWatchTap: { print("To Watch tapped") },
            onWatchedTap: { print("Watched tapped") }
        )
        
        // Beispiel-Card ohne Buttons
        AnimeCard(
            anime: Anime.example2,
            showActionButtons: false
        )
    }
    .padding()
    .background(Color.App.bgPrimary)
    .preferredColorScheme(.dark)
}

