//
//  MovieTableViewCell.swift
//  ios101-lab5-flix1
//
//  Created by Jaylen Smith on 3/21/24.
//

import UIKit
import Nuke

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
