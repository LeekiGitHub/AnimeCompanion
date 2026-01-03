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
    // MARK: - State-Eigenschaften
    // @State bedeutet, dass SwiftUI automatisch die View aktualisiert,
    // wenn sich diese Werte ändern
    
    /// Der aktuelle Suchtext
    @State private var searchText: String = ""
    
    /// Die Liste der gefundenen Animes
    @State private var searchResults: [Anime] = []
    
    /// Zeigt an, ob gerade gesucht wird (für Loading-Indicator)
    @State private var isSearching: Bool = false
    
    /// Das Repository für den Datenzugriff
    /// Wir verwenden das Protocol, nicht die konkrete Klasse!
    /// Das macht es später einfach, die Datenquelle zu wechseln
    private let repository: AnimeRepository = AnimeRepository()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // MARK: - Suchleiste
                
                VStack(spacing: 12) {
                    // Unsere wiederverwendbare SearchBar-Komponente
                    SearchBar(
                        searchText: $searchText,
                        placeholder: "Search anime...",
                        onFilterTap: {
                            // Hier können wir später Filter-Logik einbauen
                            print("Filter tapped")
                        }
                    )
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Filter-Chips (später erweiterbar)
                    // ScrollView für horizontales Scrollen
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            // "All" Filter-Chip (aktuell ausgewählt)
                            FilterChip(
                                title: "All",
                                isSelected: true
                            )
                            
                            // Weitere Filter-Chips (später funktional)
                            FilterChip(
                                title: "TV",
                                isSelected: false
                            )
                            
                            FilterChip(
                                title: "Movie",
                                isSelected: false
                            )
                            
                            FilterChip(
                                title: "OVA",
                                isSelected: false
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 8)
                
                Divider()
                    .overlay(Color.App.divider)
                
                // MARK: - Ergebnisse-Liste
                
                // Zeigt die Suchergebnisse an
                if isSearching {
                    // Loading-Indicator während der Suche
                    Spacer()
                    ProgressView()
                        .tint(Color.App.accentPrimary)
                    Spacer()
                } else if searchResults.isEmpty && !searchText.isEmpty {
                    // Keine Ergebnisse gefunden
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .font(.largeTitle)
                            .foregroundStyle(Color.App.textSecondary)
                        Text("No results found")
                            .font(.headline)
                            .foregroundStyle(Color.App.textPrimary)
                        Text("Try a different search term")
                            .font(.subheadline)
                            .foregroundStyle(Color.App.textSecondary)
                    }
                    Spacer()
                } else if searchResults.isEmpty {
                    // Noch keine Suche durchgeführt - zeigt Beispiel-Animes
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            // Zeigt Beispiel-Animes an, wenn noch nicht gesucht wurde
                            ForEach(Anime.examples) { anime in
                                AnimeCard(
                                    anime: anime,
                                    showActionButtons: true,
                                    onWatchingTap: {
                                        handleAddToWatching(anime)
                                    },
                                    onToWatchTap: {
                                        handleAddToToWatch(anime)
                                    },
                                    onWatchedTap: {
                                        handleAddToWatched(anime)
                                    }
                                )
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                } else {
                    // Zeigt die Suchergebnisse an
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            // ForEach durchläuft alle Suchergebnisse
                            // LazyVStack lädt nur die sichtbaren Cards (bessere Performance)
                            ForEach(searchResults) { anime in
                                AnimeCard(
                                    anime: anime,
                                    showActionButtons: true,
                                    onWatchingTap: {
                                        handleAddToWatching(anime)
                                    },
                                    onToWatchTap: {
                                        handleAddToToWatch(anime)
                                    },
                                    onWatchedTap: {
                                        handleAddToWatched(anime)
                                    }
                                )
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Search")
        }
        .appTheme()
        // MARK: - Such-Logik
        // .onChange beobachtet Änderungen am searchText
        // Wenn sich der Suchtext ändert, wird performSearch() aufgerufen
        .onChange(of: searchText) { oldValue, newValue in
            performSearch(query: newValue)
        }
        // Führt beim ersten Laden eine Suche mit leerem String durch
        // Das zeigt die Beispiel-Animes
        .onAppear {
            performSearch(query: "")
        }
    }
    
    // MARK: - Funktionen
    
    /// Führt die Suche durch
    /// - Parameter query: Der Suchbegriff
    private func performSearch(query: String) {
        // Setzt isSearching auf true, um den Loading-Indicator zu zeigen
        isSearching = true
        
        // Task ist für asynchrone Operationen (API-Aufrufe, etc.)
        Task {
            do {
                // Ruft die Suchfunktion des Repositories auf
                // try await bedeutet: Wir warten auf das Ergebnis und behandeln Fehler
                let results = try await repository.searchAnime(query: query)
                
                // Aktualisiert die Ergebnisse im Haupt-Thread
                // @MainActor stellt sicher, dass UI-Updates im Haupt-Thread passieren
                await MainActor.run {
                    searchResults = results
                    isSearching = false
                }
            } catch {
                // Bei einem Fehler zeigen wir eine Fehlermeldung
                // Später können wir hier eine bessere Fehlerbehandlung einbauen
                print("Search error: \(error)")
                await MainActor.run {
                    searchResults = []
                    isSearching = false
                }
            }
        }
    }
    
    /// Fügt ein Anime zur Watching-Liste hinzu
    private func handleAddToWatching(_ anime: Anime) {
        Task {
            do {
                try await repository.addToWatching(anime)
                print("Added \(anime.displayTitle) to watching")
            } catch {
                print("Error adding to watching: \(error)")
            }
        }
    }
    
    /// Fügt ein Anime zur To Watch-Liste hinzu
    private func handleAddToToWatch(_ anime: Anime) {
        Task {
            do {
                try await repository.addToToWatch(anime)
                print("Added \(anime.displayTitle) to to watch")
            } catch {
                print("Error adding to to watch: \(error)")
            }
        }
    }
    
    /// Fügt ein Anime zur Watched-Liste hinzu
    private func handleAddToWatched(_ anime: Anime) {
        Task {
            do {
                try await repository.addToWatched(anime)
                print("Added \(anime.displayTitle) to watched")
            } catch {
                print("Error adding to watched: \(error)")
            }
        }
    }
}

#Preview {
    SearchView()
        .preferredColorScheme(.dark)
}

