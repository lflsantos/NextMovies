//
//  RegisterMovieViewController.swift
//  Movies
//
//  Created by Lucas Santos on 09/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class RegisterMovieViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfCategories: UITextField!
    @IBOutlet weak var tfDuration: UITextField!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var sliderRating: UISlider!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var ivPoster: UIImageView!
    
    var movie: Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle()
        completeFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func setTitle() {
        if (movie != nil) {
            title = "Edit Movie"
        } else {
            title = "Add Movie"
        }
    }
    
    func completeFields() {
        guard let movie = movie else { return }
        tfTitle.text = movie.title
        tfDuration.text = movie.duration
        tfCategories.text = movie.categories?.joined(separator: " | ")
        lblRating.text = String(format:"%.1f", movie.rating ?? 0.0)
        sliderRating.value = Float(movie.rating ?? 0.0)
        tvDescription.text = movie.summary
        ivPoster.image = UIImage(named: movie.smallImage ?? "")
    }

    //MARK: - Keyboard Methods
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let height = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect).size.height
        scrollView.contentInset.bottom = height
        scrollView.scrollIndicatorInsets.bottom = height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }

    @IBAction func ratingChanged(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.lblRating.text = String(format:"%.1f", sender.value)
        }
    }
    
    @IBAction func selectImage(_ sender: Any) {
    }
    
    @IBAction func save(_ sender: Any) {
    }
}
