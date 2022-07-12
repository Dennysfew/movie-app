//
//  HomeViewController.swift
//  Movie-app
//
//  Created by Denys on 09.07.2022.
//

import UIKit

class HomeViewController: UIViewController {
    var movies = MovieResorce.ferchMovie()
    
    @IBOutlet weak var watchListCollectionView: UICollectionView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var libraryCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iFilm"
        
        watchListCollectionView.dataSource = self
        trendingCollectionView.dataSource = self
        libraryCollectionView.dataSource = self
    }
    @IBAction func addButtonTapped(_ sender: Any) {
    
    }
  
}


// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    func collectionView( _ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView( _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = watchListCollectionView.dequeueReusableCell(withReuseIdentifier: "WatchListCollectionViewCell", for: indexPath) as! WatchListCollectionViewCell
        let movie1 = movies[indexPath.item]
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
