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
    static let lightBackgroundColor = UIColor(r: 193, g: 193, b: 193)
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

extension UIImage {
    static let darkSettingsImage = UIImage(named: "ic_tab_settings_dark")
    static let darkMoviesImage = UIImage(named: "ic_tab_movies_dark")
    static let lightSettingsImage = UIImage(named: "ic_tab_settings_light")
    static let lightMoviesImage = UIImage(named: "ic_tab_movies_light")
}

enum Margin {
    static let horizontal: CGFloat = 24
    static let verticalLarge: CGFloat = 24
    static let verticalVeryLarge: CGFloat = 72
}

struct AppTheme {
    var statusBarStyle: UIStatusBarStyle
    var barStyle: UIBarStyle
    var barText: UIColor
    var backgroundColor: UIColor
    var separatorColor: UIColor
    var textColor: UIColor
    var titleColor: UIColor
    var settingsTabImage: UIImage?
    var moviesTabImage: UIImage?

    static let lightTheme = AppTheme(
        statusBarStyle: .default,
        barStyle: .default,
        barText: .black,
        backgroundColor: .lightBackgroundColor,
        separatorColor: .black,
        textColor: .darkText,
        titleColor: .darkText,
        settingsTabImage: .lightSettingsImage,
        moviesTabImage: .lightMoviesImage)

    static let darkTheme = AppTheme(
        statusBarStyle: .lightContent,
        barStyle: .black,
        barText: .white,
        backgroundColor: .darkGray,
        separatorColor: .white,
        textColor: .lightText,
        titleColor: .lightText,
        settingsTabImage: .darkSettingsImage,
        moviesTabImage: .darkMoviesImage)
}

protocol Themed {
    func applyTheme(_ notification: Notification?)
}
