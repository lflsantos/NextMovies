//
//  GenresTableViewController.swift
//  Movies
//
//  Created by Lucas Santos on 16/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit
import CoreData

class GenresTableViewController: UITableViewController {
    
    var fetchedResultController: NSFetchedResultsController<Genre>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGenres()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let vc = parent as? RegisterMovieViewController, let indexPaths = self.tableView.indexPathsForSelectedRows {
            vc.genres = []
            for indexPath in indexPaths{
                if let genre = fetchedResultController?.object(at: indexPath){
                    vc.genres.append(genre)
                }
            }
        }
    }
    
    func loadGenres(){
        let fetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Genre.name, ascending: true)
        
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController?.delegate = self
        
        do {
            try fetchedResultController?.performFetch()
        } catch {
            print(error)
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
        return cell
    }
 

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
 

    @IBAction func addGenre(_ sender: Any) {
        let alert = UIAlertController(title: "Gênero", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let genreName = alert.textFields?.first?.text
            let genre = Genre(context: self.context)
            genre.name = genreName
            self.saveContext()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addTextField { (textField) in
            textField.placeholder = "Nome"
        }
        present(alert, animated: true, completion: nil)
    }
}

extension GenresTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}
