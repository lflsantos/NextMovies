//
//  CustomViewController.swift
//  Movies
//
//  Created by Lucas Santos on 24/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

protocol CustomViewController {
    associatedtype CustomView: UIView
}

extension CustomViewController where Self: UIViewController {
    var customView: CustomView {
        guard let customView = view as? CustomView else {
            fatalError("View deveria ser \(CustomView.self) mas foi \(type(of: view))")
        }
        return customView
    }
}
