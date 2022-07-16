//
//  MovieSelected.swift
//  Movie-app
//
//  Created by Denys on 16.07.2022.
//

import Foundation

struct MovieSelected: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Writer: String
    let Actors: String
    let Plot: String
    let Language: String
    let Country: String
    let Awards: String
    let imdbRating: String
    
    private enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, _Type = "Type", Poster, Runtime, Genre, Director, Writer, Actors, Plot, Language, Country, Awards, imdbRating
    }
    
}
