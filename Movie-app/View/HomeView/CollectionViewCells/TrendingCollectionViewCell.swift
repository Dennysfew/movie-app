//
//  TrendingCollectionViewCell.swift
//  Movie-app
//
//  Created by Denys on 12.07.2022.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    @IBOutlet var movieName: UILabel!
    @IBOutlet var moviePoster: UIImageView!
    
    let apiService: APIService = APIService()
    
    var movie: TrendingMovie! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let movie = movie {
            
            
            if let data = try? Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/original\(movie.posterPath)")!) {
                self.moviePoster.image = UIImage(data: data)
            }
            self.movieName.text = movie.originalTitle
        } else {
            moviePoster.image = nil
            movieName.text = nil
        }
        moviePoster.layer.cornerRadius = 5.0
        moviePoster.layer.masksToBounds = true
    }
}
