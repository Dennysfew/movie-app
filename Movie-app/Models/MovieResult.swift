//
//  MovieResult.swift
//  Movie-app
//
//  Created by Denys on 16.07.2022.
//

import Foundation

struct MovieResult: Codable {
    let search: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}
struct TrendingMovieResult: Codable {
    let search: Movie
    
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
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
