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
    let original_title: String
    let poster_path: String
    
    private enum CodingKeys: String, CodingKey {
        case original_title, poster_path
    }
    
}
