//
//  AnimeRepositoryProtocol.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 01.01.26.
//
//  Protocol (Interface) für den Anime-Datenzugriff.
//  Ein Protocol definiert, WAS gemacht werden soll, nicht WIE.
//  Das ist wichtig, weil wir später die Datenquelle wechseln können
//  (z.B. von Dummy-Daten zu SQLite zu Firebase) ohne den Rest des Codes zu ändern.
//
//  Alle Klassen, die dieses Protocol implementieren, müssen diese Funktionen bereitstellen.

import Foundation

/// Definiert die Schnittstelle für den Zugriff auf Anime-Daten
/// Jede Klasse, die dieses Protocol implementiert, muss alle diese Funktionen haben
protocol AnimeRepositoryProtocol {
    
    // MARK: - Suchfunktionen
    
    /// Sucht nach Animes basierend auf einem Suchbegriff
    /// - Parameter query: Der Suchbegriff (z.B. "Attack on Titan")
    /// - Returns: Eine Liste von Animes, die zur Suche passen
    /// - Throws: Kann einen Fehler werfen (z.B. wenn die API nicht erreichbar ist)
    func searchAnime(query: String) async throws -> [Anime]
    
    // MARK: - Listen-Funktionen
    
    /// Gibt alle Animes zurück, die der Benutzer gerade schaut
    func getWatchingList() async throws -> [Anime]
    
    /// Gibt alle Animes zurück, die der Benutzer bereits gesehen hat
    func getWatchedList() async throws -> [Anime]
    
    /// Gibt alle Animes zurück, die der Benutzer noch schauen möchte
    func getToWatchList() async throws -> [Anime]
    
    // MARK: - Hinzufügen-Funktionen
    
    /// Fügt ein Anime zur "Watching"-Liste hinzu
    /// - Parameter anime: Das Anime, das hinzugefügt werden soll
    func addToWatching(_ anime: Anime) async throws
    
    /// Fügt ein Anime zur "Watched"-Liste hinzu
    /// - Parameter anime: Das Anime, das hinzugefügt werden soll
    func addToWatched(_ anime: Anime) async throws
    
    /// Fügt ein Anime zur "To Watch"-Liste hinzu
    /// - Parameter anime: Das Anime, das hinzugefügt werden soll
    func addToToWatch(_ anime: Anime) async throws
    
    // MARK: - Entfernen-Funktionen
    
    /// Entfernt ein Anime aus der "Watching"-Liste
    /// - Parameter anime: Das Anime, das entfernt werden soll
    func removeFromWatching(_ anime: Anime) async throws
    
    /// Entfernt ein Anime aus der "Watched"-Liste
    /// - Parameter anime: Das Anime, das entfernt werden soll
    func removeFromWatched(_ anime: Anime) async throws
    
    /// Entfernt ein Anime aus der "To Watch"-Liste
    /// - Parameter anime: Das Anime, das entfernt werden soll
    func removeFromToWatch(_ anime: Anime) async throws
}

