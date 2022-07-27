//
//  MovieSelected.swift
//  Movie-app
//
//  Created by Denys on 16.07.2022.
//

import Foundation

struct MovieSelected: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String
    let imdbRating: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title",year = "Year", imdbID, type = "Type", poster = "Poster", runtime = "Runtime", genre = "Genre", director = "Director", writer = "Writer", actors = "Actors", plot = "Plot", language = "Language", country = "Country", awards = "Awards", imdbRating
    }
    
}
