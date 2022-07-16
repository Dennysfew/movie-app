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
    
    var movie: MovieResorce! {
        didSet {
            self.updateUI()
        }
    }
    func updateUI() {
        if let movie = movie {
            moviePoster.image = movie.moviePoster
            movieName.text = movie.movieName
        } else {
            moviePoster.image = nil
            movieName.text = nil
        }
        moviePoster.layer.cornerRadius = 5.0
        moviePoster.layer.masksToBounds = true
    }
}
