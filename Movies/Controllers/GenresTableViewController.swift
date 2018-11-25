//
//  GenresTableViewController.swift
//  Movies
//
//  Created by Lucas Santos on 16/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit
import CoreData

protocol GenreSelectionDelegate: class {
    func didSelect(Genres genres: [Genre])
}

class GenresTableViewController: UITableViewController {

    // MARK: - Properties
    var fetchedResultController: NSFetchedResultsController<Genre>?
    weak var delegate: GenreSelectionDelegate?
    var genres: [Genre] = []

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGenres()
        selectGenres()

        applyTheme(nil)
        localize()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applyTheme(_:)),
                                               name: UserDefaults.didChangeNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let delegate = delegate, let indexPaths = self.tableView.indexPathsForSelectedRows {
            var genres: [Genre] = []
            for indexPath in indexPaths {
                if let genre = fetchedResultController?.object(at: indexPath) {
                    genres.append(genre)
                }
            }
            delegate.didSelect(Genres: genres)
        }
    }

    // MARK: - Methods
    func localize() {
        title = Localization.genresTitle
    }

    func loadGenres() {
        let fetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Genre.name, ascending: true)

        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                             managedObjectContext: context,
                                                             sectionNameKeyPath: nil,
                                                             cacheName: nil)
        fetchedResultController?.delegate = self

        do {
            try fetchedResultController?.performFetch()
        } catch {
            print(error)
        }
    }

    func genreExists (_ name: String, in genres: [Genre]) -> Bool {
        let fetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1

        do {
            return try context.count(for: fetchRequest) > 0 ? true : false
        } catch {
            print(error)
        }
        return false
    }

    func selectGenres() {
        for genre in genres {
            let indexPath = fetchedResultController?.indexPath(forObject: genre)
            self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController?.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath)

        let course = fetchedResultController?.object(at: indexPath)
        cell.textLabel?.text = course?.name

        let theme = UserDefaults.standard.bool(forKey: SettingsKeys.darkMode) ? AppTheme.darkTheme : AppTheme.lightTheme
        cell.backgroundColor = theme.backgroundColor
        cell.textLabel?.textColor = theme.textColor

        return cell
    }

    // MARK: - IBActions
    @IBAction func addGenre(_ sender: Any) {
        let alert = UIAlertController(title: Localization.genre,
                                      message: Localization.newGenreText,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localization.ok, style: .default, handler: { (_) in
            let genreName = alert.textFields?.first?.text?.capitalized ?? ""
            if !self.genreExists(genreName, in: self.genres) && genreName != "" {
                let genre = Genre(context: self.context)
                genre.name = genreName
                self.saveContext()
            } else {
                let existentAlert = UIAlertController(title: Localization.warning,
                                                      message: Localization.genreExists,
                                                      preferredStyle: .alert)
                existentAlert.addAction(UIAlertAction(title: Localization.ok, style: .cancel, handler: nil))
                self.present(existentAlert, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: Localization.cancel, style: .cancel, handler: nil))
        alert.addTextField { (textField) in
            textField.placeholder = Localization.name
        }
        present(alert, animated: true, completion: nil)
    }
}

extension GenresTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}

extension GenresTableViewController: Themed {
    @objc func applyTheme(_ notification: Notification?) {
        let theme = UserDefaults.standard.bool(forKey: SettingsKeys.darkMode) ? AppTheme.darkTheme : AppTheme.lightTheme
        view.backgroundColor = theme.backgroundColor
        tableView.backgroundColor = theme.backgroundColor
        tableView.separatorColor = theme.separatorColor
        tableView.reloadData()
    }
}
