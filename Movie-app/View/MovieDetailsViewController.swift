//
//  MovieDetailsViewController.swift
//  Movie-app
//
//  Created by Denys on 13.07.2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet var movieName: UILabel!
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var runtimeLb: UILabel!
    @IBOutlet var genreLb: UILabel!
    @IBOutlet var plotLb: UILabel!
    @IBOutlet var writerLb: UILabel!
    @IBOutlet var actorsLb: UILabel!
    @IBOutlet var directorLb: UILabel!
    @IBOutlet var languageLb: UILabel!
    @IBOutlet var countryLb: UILabel!
    @IBOutlet var awardsLb: UILabel!
    @IBOutlet var imdbRatingLb: UILabel!
    let apiService: APIService = APIService()
    
    var movie: Movie?
    
    var movieSelected: MovieSelected? {
        didSet{
            
            guard let movieName = movieSelected?.Title else { return }
            guard let runtime = movieSelected?.Runtime else { return }
            guard let genre = movieSelected?.Genre else { return }
            guard let plot = movieSelected?.Plot else { return }
            guard let writer = movieSelected?.Writer else { return }
            guard let actors = movieSelected?.Actors else { return }
            guard let director = movieSelected?.Director else { return }
            guard let language = movieSelected?.Language else { return }
            guard let country = movieSelected?.Country else { return }
            guard let awards = movieSelected?.Awards else { return }
            guard let imdbRating = movieSelected?.imdbRating else { return }
            
            DispatchQueue.main.async {
                self.movieName.text = String(movieName)
                self.runtimeLb.text = String(runtime)
                self.genreLb.text = String(genre)
                self.plotLb.text = String(plot)
                self.writerLb.text = String(writer)
                self.actorsLb.text = String(actors)
                self.directorLb.text = String(director)
                self.languageLb.text = String(language)
                self.countryLb.text = String(country)
                self.awardsLb.text = String(awards)
                self.imdbRatingLb.text = String(imdbRating)
                
            }
            
            guard let posterImageUrl = movieSelected?.Poster else { return }
            
            if let data = try? Data(contentsOf: URL(string: posterImageUrl)!) {
                self.moviePoster.image = UIImage(data: data)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let movie = movie else { return }
              
        apiService.fetchData(urlString: "https://www.omdbapi.com/?i=\(movie.imdbID)&apikey=479b27a7") { [weak self] value in
                  guard let data = value else { return }
                  
                  do {
                      
                      let movieSelected = try JSONDecoder().decode(MovieSelected.self, from: data)
                      
                      DispatchQueue.main.async {
                          
                          self?.movieSelected = movieSelected
                          
                      }
                  }
                  catch {
                      print(error)
                      return
                  }
              }
              
          }

}

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
