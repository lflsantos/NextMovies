//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Lucas Santos on 06/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivPoster: UIImageView!
    
    
    func prepareCell(_ movie: Movie){
        lblTitle.text = movie.title
        ivPoster.image = UIImage(named: (movie.image ?? ""))
    }
}
