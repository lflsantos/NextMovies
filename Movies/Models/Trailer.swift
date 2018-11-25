//
//  Trailer.swift
//  Movies
//
//  Created by Lucas Santos on 25/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

struct Trailer: Decodable {
    let resultCount: Int
    let results: [TrailerDetails]
}

struct TrailerDetails: Decodable {
    let previewUrl: String
}
