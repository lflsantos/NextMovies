//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Lucas Santos on 08/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit
import AVKit

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
    @IBOutlet weak var trailerView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var lblNoTrailer: UILabel!

    // MARK: - Properties
    var movie: Movie!
    var player: AVPlayer?
    let playerLayer = AVPlayerLayer()

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
        loadTrailer()
        applyTheme(nil)
        localize()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applyTheme(_:)),
                                               name: UserDefaults.didChangeNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        pauseVideo(nil)
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
        lblSinopse.text = movie.summary == "" ? "" : Localization.description
        lblDescription.text = movie.summary
    }

    func localize() {
        title = movie.title
    }

    func loadTrailer() {
        guard let title = movie.title else { return }
        REST.requestTrailer(movieName: title) { [weak self] (success, url) in
            if let url = url {
                self?.setupTrailer(url)
            } else {
                DispatchQueue.main.async {
                    self?.lblNoTrailer.text = Localization.noTrailer
                }
            }
        }
    }

    func setupTrailer(_ url: URL) {
        player = AVPlayer(url: url)
        DispatchQueue.main.async {
            self.playButton.isHidden = false

            self.playerLayer.player = self.player
            self.playerLayer.frame = self.trailerView.bounds

            self.trailerView.layer.addSublayer(self.playerLayer)
            self.playerLayer.isHidden = true
            self.trailerView.bringSubviewToFront(self.playButton)

            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.playerDidFinishPlaying(_:)),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: self.player?.currentItem)

            let tap = UITapGestureRecognizer(target: self, action: #selector(self.pauseVideo(_:)))
            self.trailerView.addGestureRecognizer(tap)
        }
    }

    // MARK: - Actions
    @IBAction func play(_ sender: Any) {
        guard let player = player else { return }
        playerLayer.isHidden = false
        playButton.isHidden = true
        player.play()
    }

    // MARK: - Player
    @objc func playerDidFinishPlaying(_ notification: NSNotification) {
        playButton.isHidden = false
        playerLayer.isHidden = true
        playerLayer.removeFromSuperlayer()
    }

    @objc func pauseVideo(_ sender: UITapGestureRecognizer?) {
        player?.pause()
        playButton.isHidden = !(lblNoTrailer.text == "")
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
        lblNoTrailer.textColor = theme.textColor
    }
}
