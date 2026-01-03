//
//  Anime.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 01.01.26.
//
//  Datenmodell für ein Anime.
//  Dieses Struct enthält alle Informationen, die wir über ein Anime speichern wollen.
//  Es ist unabhängig von der Datenquelle (SQLite, Firebase, etc.) - das macht es flexibel.

import Foundation

/// Repräsentiert ein Anime mit allen wichtigen Informationen
struct Anime: Identifiable, Codable {
    // MARK: - Eigenschaften (Properties)
    
    /// Eindeutige ID des Animes (z.B. von AniList API)
    /// Identifiable bedeutet, dass SwiftUI diese ID automatisch verwendet
    let id: Int
    
    /// Titel des Animes auf Englisch
    let titleEnglish: String?
    
    /// Titel des Animes auf Japanisch (Romaji)
    let titleRomaji: String?
    
    /// Titel des Animes in japanischen Zeichen (Kanji/Hiragana)
    let titleNative: String?
    
    /// URL zum Cover-Bild des Animes
    /// Optional, weil nicht jedes Anime ein Bild haben muss
    let coverImage: String?
    
    /// Beschreibung des Animes
    let description: String?
    
    /// Liste der Genres (z.B. ["Action", "Adventure", "Fantasy"])
    let genres: [String]
    
    /// Anzahl der Episoden (kann nil sein, wenn noch nicht bekannt)
    let episodes: Int?
    
    /// Anzahl der Staffeln/Seasons
    let seasons: Int?
    
    /// Status des Animes (z.B. "RELEASING", "FINISHED", "NOT_YET_RELEASED")
    let status: String?
    
    /// Format des Animes (z.B. "TV", "MOVIE", "OVA")
    let format: String?
    
    // MARK: - Computed Properties (berechnete Eigenschaften)
    
    /// Gibt den bevorzugten Titel zurück
    /// Versucht zuerst Englisch, dann Romaji, dann Native
    /// Das ist praktisch, weil wir nicht immer alle Titel haben
    var displayTitle: String {
        // ?? ist der "nil-coalescing operator" - wenn titleEnglish nil ist, nimm titleRomaji
        return titleEnglish ?? titleRomaji ?? titleNative ?? "Unknown Title"
    }
    
    /// Gibt den alternativen Titel zurück (falls vorhanden)
    /// Nützlich für die Anzeige, wenn wir beide Titel zeigen wollen
    var alternativeTitle: String? {
        if let english = titleEnglish, let romaji = titleRomaji, english != romaji {
            return romaji
        }
        return titleNative
    }
}

// MARK: - Beispiel-Daten (Dummy Data)
/// Diese Extension enthält Beispiel-Animes für Tests und Previews
/// Später können wir diese entfernen, wenn wir echte Daten haben
extension Anime {
    /// Erstellt ein Beispiel-Anime für Tests
    static let example1 = Anime(
        id: 1,
        titleEnglish: "Attack on Titan",
        titleRomaji: "Shingeki no Kyojin",
        titleNative: "進撃の巨人",
        coverImage: nil, // Später können wir hier echte URLs einfügen
        description: "Humanity fights for survival against the Titans.",
        genres: ["Action", "Drama", "Horror"],
        episodes: 75,
        seasons: 4,
        status: "FINISHED",
        format: "TV"
    )
    
    static let example2 = Anime(
        id: 2,
        titleEnglish: "Demon Slayer",
        titleRomaji: "Kimetsu no Yaiba",
        titleNative: "鬼滅の刃",
        coverImage: nil,
        description: "A boy becomes a demon slayer to save his sister.",
        genres: ["Action", "Supernatural", "Historical"],
        episodes: 44,
        seasons: 2,
        status: "RELEASING",
        format: "TV"
    )
    
    static let example3 = Anime(
        id: 3,
        titleEnglish: "Spirited Away",
        titleRomaji: "Sen to Chihiro no Kamikakushi",
        titleNative: "千と千尋の神隠し",
        coverImage: nil,
        description: "A young girl enters a world of spirits.",
        genres: ["Adventure", "Supernatural", "Drama"],
        episodes: 1,
        seasons: 1,
        status: "FINISHED",
        format: "MOVIE"
    )
    
    /// Liste mit allen Beispiel-Animes
    /// Nützlich für Previews und Tests
    static let examples = [example1, example2, example3]
}

