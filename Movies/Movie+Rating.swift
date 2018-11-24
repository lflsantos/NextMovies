//
//  Movie+rating.swift
//  Movies
//
//  Created by Lucas Santos on 16/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

extension Movie {
    var formattedRating: String {
        return "⭐️ \(rating)"
    }
}
