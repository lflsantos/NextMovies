//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Lucas Santos on 08/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblSinopse: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }
    
    func setViews(){
        if let posterData = movie.poster {
            ivPoster.image = UIImage(data: posterData)
        }
        lblTitle.text = movie.title
        var genreString = ""
        for genre in movie.genre?.allObjects as! [Genre]{
            if let name = genre.name {
                genreString.append(name + "|")
            }
        }
        lblDuration.text = movie.duration
        lblRating.text = movie.formattedRating
        lblSinopse.text = movie.summary == "" ? "" : "Sinopse"
        lblDescription.text = movie.summary
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RegisterMovieViewController {
            vc.movie = movie
        }
    }
}

extension MovieDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var alpha = (scrollView.contentOffset.y/scrollView.bounds.size.height) + 0.2
        alpha = alpha > 0.7 ? 0.7 : alpha
        alpha = alpha < 0.2 ? 0.2 : alpha
        
        self.contentView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: alpha)
    }
}
