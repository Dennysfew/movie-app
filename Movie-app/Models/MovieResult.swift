//
//  MovieResult.swift
//  Movie-app
//
//  Created by Denys on 16.07.2022.
//

import Foundation

struct MovieResult: Codable {
    let Search: [Movie]
}
struct TrendingMovieResult: Codable {
    let Search: Movie
}

struct Movie: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title", year = "Year", imdbID, type = "Type", poster = "Poster"
    }
    
}
