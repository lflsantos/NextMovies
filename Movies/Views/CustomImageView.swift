//
//  CustomImageView.swift
//  Movies
//
//  Created by Lucas Santos on 06/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

@IBDesignable class CustomImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
           layer.borderColor = newValue?.cgColor
        }
    }
}
