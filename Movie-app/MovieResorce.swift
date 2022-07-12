//
//  MovieResorce.swift
//  Movie-app
//
//  Created by Denys on 12.07.2022.
//

import UIKit

class MovieResorce {
    var movieName = ""
    var moviePoster: UIImage
    
    init (movieName: String, moviePoster: UIImage)
    {
        self.movieName = movieName
        self.moviePoster = moviePoster
    }
    
    static func ferchMovie() -> [MovieResorce] {
        return[
        MovieResorce(movieName: "The Shining", moviePoster: UIImage(named: "The_Shining")!),
        MovieResorce(movieName: "Star wars: The Bad Batch", moviePoster: UIImage(named: "Star_Wars_The_Bad_Batch")!),
        MovieResorce(movieName: "Star wars", moviePoster: UIImage(named: "star_wars")!),
        MovieResorce(movieName: "The Incredibles", moviePoster: UIImage(named: "the_incredibles")!),
        MovieResorce(movieName: "Iron Man", moviePoster: UIImage(named: "iron_man")!),
        MovieResorce(movieName: "A love song for latasha", moviePoster: UIImage(named: "a_love_song_for_latasha")!),
        MovieResorce(movieName: "Rush", moviePoster: UIImage(named: "rush")!)
        ]
    }
}
