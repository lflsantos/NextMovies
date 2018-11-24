//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Lucas Santos on 06/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSinopse: UILabel!
    @IBOutlet weak var lblRating: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        ivPoster.image = nil
    }

    func prepareCell(with movie: Movie) {
        lblTitle.text = movie.title
        lblSinopse.text = movie.summary
        lblRating.text = movie.formattedRating
        if let posterData = movie.poster {
            ivPoster.image = UIImage(data: posterData)
        }
    }

    func prepareCell (with movie: MovieModel) {
        lblTitle.text = movie.title
        lblSinopse.text = movie.summary
        lblRating.text = movie.formattedRating
        ivPoster.image = UIImage(named: movie.image ?? "")
    }
}
