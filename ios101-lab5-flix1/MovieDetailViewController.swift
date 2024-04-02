//
//  MovieDetailViewController.swift
//  ios101-lab5-flix1
//
//  Created by Jaylen Smith on 3/25/24.
//

import UIKit
import Nuke

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieVote: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    
    @IBOutlet weak var favoriteButtonLabel: UIButton!
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.favoriteButtonLabel.layer.cornerRadius = favoriteButtonLabel.frame.width / 2
        self.movieTitle.text = movie.title
        self.movieOverview.text = movie.overview
        
        if let voteAverage = movie.voteAverage {
            self.movieVote.text = "Vote Average: \(voteAverage)"
        } else {
            self.movieVote.text = "No Vote"
        }
        
        if let releaseDate = movie.releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "mm:dd:yyyy"
            self.movieDate.text = dateFormatter.date(from: releaseDate)?.formatted()
        }
        
        if let posterPath = movie.posterPath, let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
            Nuke.loadImage(with: imageUrl, into: moviePosterImage)
        }
        
        if let backdropPath = movie.backdropPath, let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + backdropPath) {
            Nuke.loadImage(with: imageUrl, into: bannerImage)
        }
    }
}
