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

    @IBOutlet var emptyMoviesView: UIView!

    var fetchedResultController: NSFetchedResultsController<Movie>?
    var movies: [MovieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadMoviesCoreData()
    }

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

    }

    private func loadMovies() {
        if let path = Bundle.main.path(forResource: "Movies.json", ofType: nil) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let movieData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                movies = try decoder.decode([MovieModel].self, from: movieData)
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let nMovies = fetchedResultController?.fetchedObjects?.count ?? 0
        if nMovies == 0 {
            emptyMoviesView.frame = view.bounds
            self.view.addSubview(emptyMoviesView)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailViewController = segue.destination as? MovieDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow,
            let movie = fetchedResultController?.object(at: indexPath) {
            movieDetailViewController.movie = movie
        }
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
}

extension MoviesListTableViewController: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}
