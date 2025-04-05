//
//  Anime.swift
//  AnimeCompanionv1
//
//  Created by Yannik Leekes on 02.04.25.
//


import Foundation

struct Anime: Identifiable, Codable {
    let id: Int
    let title: String
    let genres: [Genre]
    let score: Double?
    let episodes: Int?
    let status: String?
    let year: Int?

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case title
        case genres
        case score
        case episodes
        case status
        case year
    }
}

struct Genre: Codable, Hashable {
    let name: String
}
