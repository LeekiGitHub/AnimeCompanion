import Foundation
import SwiftUI

class AnimeViewModel: ObservableObject {
    @Published var allAnimes: [Anime] = []
    @Published var filteredAnimes: [Anime] = []
    @Published var searchText: String = ""

    @Published var selectedType: String = "Anime" // Nur optisch – Manga noch ohne Funktion
    @Published var selectedGenre: String? = nil

    // Beispielhafte Genres – kannst du bei Bedarf erweitern
    let genres: [String] = [
        "Action", "Adventure", "Comedy", "Drama", "Fantasy", "Horror", "Mystery",
        "Romance", "Sci-Fi", "Slice of Life", "Sports", "Supernatural", "Thriller", "Hentai"
    ]

    init() {
        loadJSON()
    }

    func loadJSON() {
        guard let url = Bundle.main.url(forResource: "anime_data_full", withExtension: "json") else {
            print("⚠️ JSON-Datei nicht gefunden!")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Anime].self, from: data)

            DispatchQueue.main.async {
                self.allAnimes = decoded
                self.filter()
                print("✅ \(decoded.count) Animes erfolgreich geladen.")
            }
        } catch {
            print("❌ Fehler beim JSON-Parsing: \(error)")
        }
    }

    func filter() {
        var result = allAnimes

        if let genre = selectedGenre {
            result = result.filter { $0.genres.map { $0.name }.contains(genre) }
        }

        if !searchText.isEmpty {
            result = result.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }

        filteredAnimes = result
    }

}
