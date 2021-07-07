//
//  MovieCell.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 06/06/21.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        self.layer.cornerRadius = 8
        if let posterPath = movie?.posterPath,
           let title = movie?.title,
           let rating = movie?.voteAverage{
            posterImage.sd_setImage(with: URL(string: posterPath), placeholderImage: #imageLiteral(resourceName: "poster-placeholder"))
            titleLabel.text = title
            ratingLabel.text = "⭐️ \(String(rating))"
        }
    }

}
