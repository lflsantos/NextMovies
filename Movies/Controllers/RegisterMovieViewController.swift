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
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var tfHour: UITextField!
    @IBOutlet weak var tfMinutes: UITextField!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var sliderRating: UISlider!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var ivPoster: UIImageView!

    var movie: Movie!
    var genres: [Genre] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        completeFields()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func setTitle() {
        if movie != nil {
            title = "Edit Movie"
        } else {
            title = "Add Movie"
        }
    }

    func completeFields() {
        guard let movie = movie else { return }
        tfTitle.text = movie.title
        let splitTime = movie.duration?.components(separatedBy: ":")
        tfHour.text = splitTime?[0] ?? "00"
        tfMinutes.text = splitTime?[1] ?? "00"

        var genreString = ""
        if genres.count > 0 {
            for genre in genres {
                if let name = genre.name {
                    genreString.append(name + "\n")
                }
            }
        } else {
            guard let allMoviesGenres = movie.genre?.allObjects as? [Genre] else { return }
            for genre in allMoviesGenres {
                if let name = genre.name {
                    genreString.append(name + "\n")
                }
            }
        }
        lblGenres.text = genreString

        lblRating.text = String(format: "%f.1", movie.rating)
        sliderRating.value = Float(movie.rating)
        tvDescription.text = movie.summary
        if let posterData = movie.poster {
            ivPoster.image = UIImage(data: posterData)
        }

    }

    // MARK: - Keyboard Methods
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let height = keyboardFrame.size.height
        scrollView.contentInset.bottom = height
        scrollView.scrollIndicatorInsets.bottom = height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }

    @IBAction func ratingChanged(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.lblRating.text = String(format: "%.1f", sender.value)
        }
    }

    @IBAction func selectGenres(_ sender: Any) {
    }

    @IBAction func selectImage(_ sender: Any) {
        let alert = UIAlertController(title: "Foto de Perfil",
                                      message: "Escolha sua foto",
                                      preferredStyle: .actionSheet)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { (_) in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }

        let photoAlbumAction = UIAlertAction(title: "Álbum de fotos", style: .default) { (_) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photoAlbumAction)

        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func save(_ sender: Any) {
        if movie == nil {
            movie = Movie(context: context)
        }
        movie.title = tfTitle.text
        let hourString = tfHour.text ?? "00"
        let minutesString = tfMinutes.text ?? "00"
        movie.duration = hourString + ":" + minutesString
        movie.summary = tvDescription.text
        movie.rating = sliderRating.value
        movie.poster = ivPoster.image?.pngData()

        saveContext()
        navigationController?.popViewController(animated: true)
    }
}

extension RegisterMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }

        let smallSize = CGSize(width: 300, height: 300)
        UIGraphicsBeginImageContext(smallSize)
        image.draw(in: CGRect(x: 0, y: 0, width: smallSize.width, height: smallSize.height))
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        ivPoster.image = smallImage

        dismiss(animated: true, completion: nil)
    }
}
