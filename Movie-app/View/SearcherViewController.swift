//
//  ViewController.swift
//  Movie-app
//
//  Created by Denys on 09.07.2022.
//

import UIKit
import SafariServices

class SearcherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var movieSearchTableView: UITableView!
    @IBOutlet var movieSearchField: UITextField!
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchTableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier )
        movieSearchTableView.delegate = self
        movieSearchTableView.dataSource = self
        movieSearchField.delegate = self
        
    }
    
    //Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovie()
        return true
    }
    func searchMovie() {
        movieSearchField.resignFirstResponder()
        
        // Check weather field contains a text
        
        guard let text = movieSearchField.text, !text.isEmpty else {
            return
        }
        
        let query = text.replacingOccurrences(of: " ", with: "%20")
        
        
        movies.removeAll()
        
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=3aea79ac&s=\(query)&type=movie")!, completionHandler: { data, responce, error in
            
            
            guard let data = data, error == nil else{
                return
            }
            var result: MovieResult?
            
            do{
                result = try JSONDecoder().decode(MovieResult.self , from: data)
            }
            catch{
                print("error")
            }
            guard let finalResult = result else {
                return
            }
            // Update our movie array
            let newMovies = finalResult.Search
            self.movies.append(contentsOf: newMovies)
            
            DispatchQueue.main.async {
                
                self.movieSearchTableView.reloadData()
            }
            
        }).resume()
        
        
    }
    
}
struct MovieResult: Codable {
    let Search: [Movie]
}

struct Movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String
    
    private enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, _Type = "Type", Poster
    }
    
}
extension SearcherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
}

extension SearcherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "movieDetailsvc") as! MovieDetailsViewController
        vc.movie = movies[indexPath.row]
        
        
//        let url = "https://www.imdb.com/title/\(movies[indexPath.row].imdbID)/"
//        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
        
    }
}
