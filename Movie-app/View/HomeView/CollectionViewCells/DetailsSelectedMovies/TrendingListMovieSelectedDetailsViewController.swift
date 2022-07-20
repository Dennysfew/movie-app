//
//  TrendingListMovieSelectedDetailsViewController.swift
//  Movie-app
//
//  Created by Denys on 18.07.2022.
//



import UIKit
import CoreData
import SafariServices
class TrendingListMovieSelectedDetailsViewController: UIViewController {
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
    var trendyMovieOriginalTitle: String!
    var trendyMovieImdbID = "No id"
    
    var trendingMovieSelected: [Movie]? {
        didSet{
            self.trendyMovieImdbID = self.trendingMovieSelected![0].imdbID
            
            apiService.fetchData(urlString: "https://www.omdbapi.com/?i=\(trendyMovieImdbID)&apikey=479b27a7") { [weak self] value in
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
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        let query = trendyMovieOriginalTitle.replacingOccurrences(of: " ", with: "%20")
        
        
        let urlDetails = "https://www.omdbapi.com/?apikey=3aea79ac&s=\(query)&type=movie"
        
        apiService.fetchData(urlString: urlDetails) { [weak self] value in
            guard let data = value else { return }
            
            do {
                
                let trendingMoviesSelected = try JSONDecoder().decode(MovieResult.self, from: data)
                
                
                DispatchQueue.main.async {
                    
                    self?.trendingMovieSelected = trendingMoviesSelected.Search
                    
                }
            }
            catch {
                print(error)
                return
            }
        }
    
    }
    @IBAction func moreButtonTapped(_ sender: Any) {
        let url = "https://www.imdb.com/title/\(trendyMovieImdbID ?? "")/"
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
        
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        
        transitionToHomeScreen()
    }
    func transitionToHomeScreen() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}