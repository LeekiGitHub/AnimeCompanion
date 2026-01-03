//
//  AnimeRepository.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 01.01.26.
//
//  Konkrete Implementierung des AnimeRepositoryProtocol.
//  Aktuell verwendet diese Klasse Dummy-Daten (Beispiel-Daten).
//  Später können wir diese Klasse ersetzen durch:
//  - SQLiteAnimeRepository (für lokale SQLite-Datenbank)
//  - FirebaseAnimeRepository (für Firebase Cloud-Datenbank)
//  - AniListAnimeRepository (für AniList API)
//
//  Wichtig: Die Views wissen nichts von dieser Klasse!
//  Sie verwenden nur das Protocol (AnimeRepositoryProtocol).
//  Das macht es einfach, die Datenquelle zu wechseln.

import Foundation

/// Konkrete Implementierung des Anime-Repositories mit Dummy-Daten
/// Diese Klasse implementiert das AnimeRepositoryProtocol
/// Das bedeutet: Sie muss alle Funktionen aus dem Protocol bereitstellen
class AnimeRepository: AnimeRepositoryProtocol {
    
    // MARK: - Private Eigenschaften
    // Diese Listen speichern die Animes in den verschiedenen Kategorien
    // Später werden diese durch eine echte Datenbank ersetzt
    
    /// Liste der Animes, die der Benutzer gerade schaut
    /// @Published bedeutet, dass SwiftUI automatisch Updates bekommt, wenn sich die Liste ändert
    private var watchingList: [Anime] = []
    
    /// Liste der Animes, die der Benutzer bereits gesehen hat
    private var watchedList: [Anime] = []
    
    /// Liste der Animes, die der Benutzer noch schauen möchte
    private var toWatchList: [Anime] = []
    
    // MARK: - Initialisierung
    
    /// Initialisiert das Repository mit Beispiel-Daten
    /// Das macht es einfacher zu testen und zu entwickeln
    init() {
        // Wir starten mit ein paar Beispiel-Animes in den Listen
        // Später werden diese aus einer Datenbank geladen
        watchingList = [Anime.example1]
        watchedList = [Anime.example2]
        toWatchList = [Anime.example3]
    }
    
    // MARK: - Suchfunktionen
    
    /// Sucht nach Animes basierend auf einem Suchbegriff
    /// Aktuell durchsucht es nur die Beispiel-Daten
    /// Später wird hier eine echte API-Anfrage gemacht
    func searchAnime(query: String) async throws -> [Anime] {
        // Simuliert eine kleine Verzögerung (wie bei einer echten API-Anfrage)
        // try await Task.sleep(nanoseconds: 500_000_000) // 0.5 Sekunden
        
        // Wenn die Suche leer ist, geben wir alle Beispiel-Animes zurück
        if query.isEmpty {
            return Anime.examples
        }
        
        // Konvertiert den Suchbegriff zu Kleinbuchstaben für bessere Suche
        let lowercasedQuery = query.lowercased()
        
        // Filtert die Beispiel-Animes basierend auf dem Suchbegriff
        // Wir suchen im englischen Titel, Romaji-Titel und in den Genres
        let results = Anime.examples.filter { anime in
            // Prüft, ob der englische Titel die Suche enthält
            let matchesEnglish = anime.titleEnglish?.lowercased().contains(lowercasedQuery) ?? false
            
            // Prüft, ob der Romaji-Titel die Suche enthält
            let matchesRomaji = anime.titleRomaji?.lowercased().contains(lowercasedQuery) ?? false
            
            // Prüft, ob eines der Genres die Suche enthält
            let matchesGenre = anime.genres.contains { genre in
                genre.lowercased().contains(lowercasedQuery)
            }
            
            // Gibt true zurück, wenn mindestens eine Bedingung erfüllt ist
            return matchesEnglish || matchesRomaji || matchesGenre
        }
        
        return results
    }
    
    // MARK: - Listen-Funktionen
    
    /// Gibt alle Animes zurück, die der Benutzer gerade schaut
    func getWatchingList() async throws -> [Anime] {
        // Simuliert eine kleine Verzögerung
        // try await Task.sleep(nanoseconds: 200_000_000) // 0.2 Sekunden
        
        return watchingList
    }
    
    /// Gibt alle Animes zurück, die der Benutzer bereits gesehen hat
    func getWatchedList() async throws -> [Anime] {
        // Simuliert eine kleine Verzögerung
        // try await Task.sleep(nanoseconds: 200_000_000) // 0.2 Sekunden
        
        return watchedList
    }
    
    /// Gibt alle Animes zurück, die der Benutzer noch schauen möchte
    func getToWatchList() async throws -> [Anime] {
        // Simuliert eine kleine Verzögerung
        // try await Task.sleep(nanoseconds: 200_000_000) // 0.2 Sekunden
        
        return toWatchList
    }
    
    // MARK: - Hinzufügen-Funktionen
    
    /// Fügt ein Anime zur "Watching"-Liste hinzu
    func addToWatching(_ anime: Anime) async throws {
        // Prüft, ob das Anime bereits in der Liste ist
        // contains prüft, ob ein Element in einem Array ist
        guard !watchingList.contains(where: { $0.id == anime.id }) else {
            // Wenn es bereits drin ist, machen wir nichts
            return
        }
        
        // Fügt das Anime zur Liste hinzu
        watchingList.append(anime)
        
        // Später: Hier würde das Anime in die Datenbank gespeichert werden
    }
    
    /// Fügt ein Anime zur "Watched"-Liste hinzu
    func addToWatched(_ anime: Anime) async throws {
        guard !watchedList.contains(where: { $0.id == anime.id }) else {
            return
        }
        
        watchedList.append(anime)
    }
    
    /// Fügt ein Anime zur "To Watch"-Liste hinzu
    func addToToWatch(_ anime: Anime) async throws {
        guard !toWatchList.contains(where: { $0.id == anime.id }) else {
            return
        }
        
        toWatchList.append(anime)
    }
    
    // MARK: - Entfernen-Funktionen
    
    /// Entfernt ein Anime aus der "Watching"-Liste
    func removeFromWatching(_ anime: Anime) async throws {
        // filter behält nur die Elemente, die die Bedingung erfüllen
        // Wir behalten also alle Animes, deren ID NICHT der ID des zu entfernenden Animes entspricht
        watchingList = watchingList.filter { $0.id != anime.id }
        
        // Später: Hier würde das Anime aus der Datenbank gelöscht werden
    }
    
    /// Entfernt ein Anime aus der "Watched"-Liste
    func removeFromWatched(_ anime: Anime) async throws {
        watchedList = watchedList.filter { $0.id != anime.id }
    }
    
    /// Entfernt ein Anime aus der "To Watch"-Liste
    func removeFromToWatch(_ anime: Anime) async throws {
        toWatchList = toWatchList.filter { $0.id != anime.id }
    }
}

