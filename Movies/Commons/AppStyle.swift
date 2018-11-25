//
//  AppStyle.swift
//  Movies
//
//  Created by Lucas Santos on 24/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

extension UIColor {
    static let cerise = UIColor(r: 234, g: 44, b: 127)
    static let greyishBrown = UIColor(r: 76, g: 76, b: 76)
    static let title = UIColor.cerise
    static let body = UIColor.white
}

extension UIColor {
    // Small variable names relevant to context
    // swiftlint:disable variable_name
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
    // swiftlint:enable variable_name
}

extension UIFont {
    static let title = UIFont.boldSystemFont(ofSize: 28)
    static let body = UIFont.systemFont(ofSize: 17)
}

enum Margin {
    static let horizontal: CGFloat = 24
    //    static let verticalSmall: CGFloat = 8
    //    static let verticalNormal: CGFloat = 16
    static let verticalLarge: CGFloat = 24
    static let verticalVeryLarge: CGFloat = 72
}
