//
//  ViewController.swift
//  Movies
//
//  Created by Lucas Santos on 06/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class MoviesListTableViewController: UITableViewController {

    
    @IBOutlet var emptyMoviesView: UIView!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    private func loadMovies() {
        if let path = Bundle.main.path(forResource: "Movies.json", ofType: nil) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do{
                let movieData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                movies = try decoder.decode([Movie].self, from: movieData)
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(movies.count == 0){
            emptyMoviesView.frame = view.bounds
            self.view.addSubview(emptyMoviesView)
        }
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieType = movies[indexPath.row].itemType else { return UITableViewCell()}
        let movie = movies[indexPath.row]
        switch movieType{
        case ItemType.list:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
            if let movies = movie.items {
                cell.setMovies(movies, with: movie.title)
            }
            cell.selectionStyle = .none
            return cell
        case ItemType.movie:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
            cell.prepareCell(with: movie)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MovieDetailViewController {
            let vc = segue.destination as? MovieDetailViewController
            guard let row = tableView.indexPathForSelectedRow?.row else { return }
            vc?.movie = movies[row]
        }
    }


}

