//
//  Movie.swift
//  Movies
//
//  Created by Lucas Santos on 06/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
    let title: String
    let categories: [String]?
    let duration: String?
    let rating: Double?
    let image: String?
    let itemType: ItemType?
    let summary: String?
    let items: [MovieModel]?
    var formattedRating: String {
        return "⭐️ \(rating ?? 0.0)"
    }
    var smallImage: String? {
        guard let image = image else { return nil }
        return image + "small"
    }
    enum CodingKeys: String, CodingKey {
        case title
        case categories
        case duration
        case rating
        case image
        case itemType
        case summary = "description"
        case items
    }
}

enum ItemType: String, Codable {
    case movie
    case list
}
