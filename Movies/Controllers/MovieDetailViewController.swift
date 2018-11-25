//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Lucas Santos on 08/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblSinopse: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    // MARK: - Properties
    var movie: Movie!

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
        applyTheme(nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applyTheme(_:)),
                                               name: UserDefaults.didChangeNotification, object: nil)
    }

    // MARK: - Methods
    func setViews() {
        if let posterData = movie.poster {
            ivPoster.image = UIImage(data: posterData)
        }
        lblTitle.text = movie.title
        var genreString = ""
        guard let allMoviesGenres = movie.genre?.allObjects as? [Genre] else { return }
        for genre in allMoviesGenres {
            if let name = genre.name {
                genreString.append(name + " | ")
            }
        }
        lblGenres.text = genreString
        lblDuration.text = movie.duration
        lblRating.text = movie.formattedRating
        lblSinopse.text = movie.summary == "" ? "" : "Sinopse"
        lblDescription.text = movie.summary
    }

    // MARK: - Navigation Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let registerMovieVC = segue.destination as? RegisterMovieViewController {
            registerMovieVC.movie = movie
        }
    }
}

extension MovieDetailViewController: Themed {
    @objc func applyTheme(_ notification: Notification?) {
        let theme = UserDefaults.standard.bool(forKey: SettingsKeys.darkMode) ? AppTheme.darkTheme : AppTheme.lightTheme
        view.backgroundColor = theme.backgroundColor
        lblTitle.textColor = theme.textColor
        lblGenres.textColor = theme.textColor
        lblDuration.textColor = theme.textColor
        lblSinopse.textColor = theme.textColor
        lblDescription.textColor = theme.textColor
    }
}
