//
//  LibraryMovieSelectedDetailsViewController.swift
//  Movie-app
//
//  Created by Denys on 16.07.2022.
//


import UIKit
import CoreData
import SafariServices
class LibraryMovieSelectedDetailsViewController: UIViewController {
    let dataController: MovieDataController = MovieDataController()
    let context = (UIApplication.shared.delegate as! AppDelegate).peristentContainer.viewContext
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
    
    var film: MovieLibrary?
    
    var movieSelected: MovieSelected? {
        didSet{
            
            guard let movieName = movieSelected?.title else { return }
            guard let runtime = movieSelected?.runtime else { return }
            guard let genre = movieSelected?.genre else { return }
            guard let plot = movieSelected?.plot else { return }
            guard let writer = movieSelected?.writer else { return }
            guard let actors = movieSelected?.actors else { return }
            guard let director = movieSelected?.director else { return }
            guard let language = movieSelected?.language else { return }
            guard let country = movieSelected?.country else { return }
            guard let awards = movieSelected?.awards else { return }
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
            
            guard let posterImageUrl = movieSelected?.poster else { return }
            
            if let data = try? Data(contentsOf: URL(string: posterImageUrl)!) {
                self.moviePoster.image = UIImage(data: data)
            }
        }
    }
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        
        guard let film = film else {
            return
        }
        
        apiService.fetchData(urlString: "https://www.omdbapi.com/?i=\(film.imdbID ?? " ")&apikey=479b27a7") { [weak self] value in
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
    @IBAction func moreButtonTapped(_ sender: Any) {
        let url = "https://www.imdb.com/title/\(movieSelected!.imdbID)/"
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
        
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        
        transitionToHomeScreen()
    }
    @IBAction func deleteButtonTapped(_ sender: Any) {
        context.delete(film!)
        dataController.save(context: context)
        transitionToHomeScreen()
    }
    func transitionToHomeScreen() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
