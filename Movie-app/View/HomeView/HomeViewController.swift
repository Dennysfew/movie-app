//
//  HomeViewController.swift
//  Movie-app
//
//  Created by Denys on 09.07.2022.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    var movies = MovieResorce.ferchMovie()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).peristentContainer.viewContext
    var models = [Film]()
    
    @IBOutlet weak var watchListCollectionView: UICollectionView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var libraryCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        watchListCollectionView.dataSource = self
        trendingCollectionView.dataSource = self
        libraryCollectionView.dataSource = self
        watchListCollectionView.delegate = self
        trendingCollectionView.delegate = self
        libraryCollectionView.delegate = self
        getAllItems()
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        
    }
    
    
    func getAllItems() {
        do {
            models = try context.fetch(Film.fetchRequest())
            
        } catch {
            print("Not got any items")
        }
        
    }
    
}


// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    func collectionView( _ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == trendingCollectionView) {
            return movies.count
        }
        
        if (collectionView == libraryCollectionView ){
            return movies.count
        }
        
        
        return models.count
    }
    func collectionView( _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = watchListCollectionView.dequeueReusableCell(withReuseIdentifier: "WatchListCollectionViewCell", for: indexPath) as! WatchListCollectionViewCell
        
        self.getAllItems()
        let movie1 = models[indexPath.item]
        cell1.movie = movie1
        
        
        if (collectionView == trendingCollectionView) {
            let cell2 = trendingCollectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as! TrendingCollectionViewCell
            let movie2 = movies[indexPath.item]
            cell2.movie = movie2
            return cell2
        }
        if (collectionView == libraryCollectionView ){
            let cell3 = libraryCollectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCollectionViewCell", for: indexPath) as! LibraryCollectionViewCell
            let movie3 = movies[indexPath.item]
            cell3.movie = movie3
            return cell3
        }
        return cell1
     
    }
  
}
// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.getAllItems()
        if (collectionView == watchListCollectionView ){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "watchListMovieSelectedDetailsvc") as! WatchListMovieSelectedDetailsViewController
            self.getAllItems()
            vc.film = models[indexPath.row]
            show(vc, sender: true)
        }
        
        if (collectionView == trendingCollectionView ){
            
        }
    }
    
    
}
