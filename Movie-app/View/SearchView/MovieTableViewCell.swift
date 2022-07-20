//
//  MovieTableViewCell.swift
//  Movie-app
//
//  Created by Denys on 12.07.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var movieName: UILabel!
    @IBOutlet var moviePoster: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    static let identifier = "MovieTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell", bundle: nil)
        
    }
    func configure(with model: Movie) {
        self.movieName.text = model.title
        let url = model.poster
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.moviePoster.image = UIImage(data: data)
        }
        
    }
}
