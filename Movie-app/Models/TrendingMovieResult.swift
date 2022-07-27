//
//  TrendingMovieResult.swift
//  Movie-app
//
//  Created by Denys on 18.07.2022.
//

import Foundation

struct TrendingMovieResults: Codable {
    let results: [TrendingMovie]
}

struct TrendingMovie: Codable {
    let originalTitle: String
    let posterPath: String
    
    private enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title", posterPath = "poster_path"
    }
    
}
