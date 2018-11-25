//
//  REST.swift
//  Movies
//
//  Created by Lucas Santos on 25/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

class REST {
    static let basePath = "https://itunes.apple.com/search?media=movie&entity=movie&term="

    static let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        configuration.timeoutIntervalForResource = 10.0
        configuration.allowsCellularAccess = false
        configuration.httpMaximumConnectionsPerHost = 5
        return configuration
    }()
    static let session = URLSession(configuration: configuration)

    class func requestTrailer(movieName: String, onComplete: @escaping (Bool, URL?) -> Void ) {
        let path = basePath + movieName.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: path) else {
            return onComplete(false, nil)
        }

        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return onComplete(false, nil)
            } else {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                    return onComplete(false, nil)
                }
                do {
                    //Pegando trailer do primeiro resultado
                    //nome inserido pelo usuário não garante que exista
                    let trailerModel = try JSONDecoder().decode(Trailer.self, from: data)
                    guard let url = URL(string: trailerModel.results.first?.previewUrl ?? "")
                        else { return onComplete(false, nil) }
                    onComplete(true, url)
                } catch {
                    print(error)
                    return onComplete(false, nil)
                }

            }
        }
        task.resume()
    }
}
