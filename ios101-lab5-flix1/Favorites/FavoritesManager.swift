//
//  FavoritesManager.swift
//  ios101-lab5-flix1
//
//  Created by Jaylen Smith on 4/1/24.
//

import Foundation

final class FavoritesManager {
    
    private let key = "Favorites"
    
    static let manager = FavoritesManager()
    
    private init() {}
    
    func addToFavorites(_ movie: Movie) {
        var movies = self.fetchMovies()
        
        if !movies.contains(where: {$0.title == movie.title}) {
            movies.append(movie)
            self.saveMovies(movies)
        }
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        return self.fetchMovies().contains(where: {$0.title == movie.title})
    }
    
    func removeFromFavorites(_ movie: Movie) {
        var movies = self.fetchMovies()
        
        if movies.contains(where: {$0.title == movie.title}) {
            movies.removeAll(where: {$0.title == movie.title})
            self.saveMovies(movies)
        }
    }
    
    func fetchMovies() -> [Movie] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        let movies = try! JSONDecoder().decode([Movie].self, from: data)
        return movies
    }
    
    private func saveMovies(_ movies: [Movie]) {
        let data = try! JSONEncoder().encode(movies)
        UserDefaults.standard.setValue(data, forKey: key)
    }
}
