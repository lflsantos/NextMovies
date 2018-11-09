//
//  ListTableViewCell.swift
//  Movies
//
//  Created by Lucas Santos on 06/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    var movies : [Movie] = []
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setMovies(_ movies: [Movie], with title: String) {
        lblTitle.text = title
        self.movies = movies
        collectionView.reloadData()
    }
    
}

extension ListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.prepareCell(movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 115)
    }
    
}
