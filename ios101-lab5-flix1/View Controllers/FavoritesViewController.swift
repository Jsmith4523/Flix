//
//  FavoritesViewController.swift
//  ios101-lab5-flix1
//
//  Created by Jaylen Smith on 4/2/24.
//

import UIKit
import Nuke

class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var movies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 200
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let favoriteMovies = FavoritesManager.manager.fetchMovies()
        self.movies = favoriteMovies
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MovieDetailViewController
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            let movie = self.movies[selectedIndexPath.row]
            destination.movie = movie
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}

//MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Movie Detail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellView = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        let movie = self.movies[indexPath.row]
        
        cellView.movieTitle.text = movie.title
        cellView.movieDescription.text = movie.overview
        
        if let postPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500"+postPath) {
            Nuke.loadImage(with: url, into: cellView.moviePosterImageView)
            cellView.moviePosterImageView.contentMode = .scaleToFill
        }
        
        return cellView
    }
}
