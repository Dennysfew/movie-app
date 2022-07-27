//
//  DataController.swift
//  Movie-app
//
//  Created by Denys on 14.07.2022.
//

import Foundation
import CoreData

class MovieDataController: ObservableObject {
    let container = NSPersistentContainer(name: "MovieModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription )")
            }
            
            
        }
    }
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!!! WUHU!")
        } catch {
            print("We cound not save the data.... ")
        }
    }
    func addMovieToWatchList(moviePoster: String, movieName: String, imdbID: String, context: NSManagedObjectContext) {
        let film = Film (context: context)
        film.id = UUID()
        film.imdbID = imdbID
        film.name = movieName
        film.poster = moviePoster
        
        save(context: context )
        
        
    }

    func addMovieToLibrary(moviePoster: String, movieName: String, imdbID: String, context: NSManagedObjectContext) {
        let film = MovieLibrary(context: context)
        film.id = UUID()
        film.imdbID = imdbID
        film.name = movieName
        film.poster = moviePoster
        
        save(context: context )
        
        
    }

}
