//
//  WatchListCollectionViewCell.swift
//  Movie-app
//
//  Created by Denys on 12.07.2022.
//

import UIKit

class WatchListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var movieName: UILabel!
    @IBOutlet var moviePoster: UIImageView!
    
    
    
    var movie: Film! {
        didSet {
            self.updateUI()
        }
    }
    
    
    
    
    
    func updateUI() {
        if let movie = movie {
            let urlPoster = movie.poster!
            if let data = try? Data(contentsOf: URL(string: urlPoster)!) {
               moviePoster.image = UIImage(data: data)
            }
               movieName.text = movie.name
        } else {
            moviePoster.image = nil
            movieName.text = nil
        }
 
        
        moviePoster.layer.cornerRadius = 5.0
        moviePoster.layer.masksToBounds = true
    }
    
}
