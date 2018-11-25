//
//  ViewController.swift
//  Movies
//
//  Created by Lucas Santos on 06/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit
import CoreData

class MoviesListTableViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet var emptyMoviesView: UIView!
    @IBOutlet weak var lblNoMovies: UILabel!

    // MARK: - Properties
    var fetchedResultController: NSFetchedResultsController<Movie>?
    var movies: [MovieModel] = []

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        applyTheme(nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applyTheme(_:)),
                                               name: UserDefaults.didChangeNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadMoviesCoreData()
    }

    // MARK: - Methods
    private func loadMoviesCoreData() {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Movie.title, ascending: true)

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

        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let nMovies = fetchedResultController?.fetchedObjects?.count ?? 0
        if nMovies == 0 {
            emptyMoviesView.frame = view.bounds
            self.view.addSubview(emptyMoviesView)
        } else {
            emptyMoviesView.removeFromSuperview()
        }
        return nMovies
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell",
                                                       for: indexPath) as? MovieTableViewCell
        else {
            return UITableViewCell()
        }

        guard let movie = fetchedResultController?.object(at: indexPath) else { return cell }
        cell.prepareCell(with: movie)
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let movie = fetchedResultController?.object(at: indexPath) else { return }
            context.delete(movie)
            saveContext()
        }
    }

    // MARK: - Navigation Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailViewController = segue.destination as? MovieDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow,
            let movie = fetchedResultController?.object(at: indexPath) {
            movieDetailViewController.movie = movie
        }
    }
}

extension MoviesListTableViewController: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}

extension MoviesListTableViewController: Themed {
    @objc func applyTheme(_ notification: Notification?) {
        let theme = UserDefaults.standard.bool(forKey: SettingsKeys.darkMode) ? AppTheme.darkTheme : AppTheme.lightTheme
        view.backgroundColor = theme.backgroundColor
        tableView.separatorColor = theme.separatorColor
        emptyMoviesView.backgroundColor = theme.backgroundColor
        lblNoMovies.textColor = theme.textColor
        navigationController?.navigationBar.barStyle = theme.barStyle
        navigationController?.navigationBar.tintColor = theme.barText

        tableView.reloadData()
    }
}
