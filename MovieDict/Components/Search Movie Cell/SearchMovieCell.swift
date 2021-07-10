//
//  SearchMovieCellCollectionViewCell.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 07/07/21.
//

import UIKit

class SearchMovieCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        self.layer.cornerRadius = 8
        if let posterPath = movie?.posterPath,
           let title = movie?.title{
            imageView.sd_setImage(with: URL(string: posterPath), placeholderImage: #imageLiteral(resourceName: "poster-placeholder"))
            titleLabel.text = title
        }
    }

}
