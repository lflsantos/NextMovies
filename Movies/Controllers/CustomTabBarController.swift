//
//  CustomTabBarController.swift
//  Movies
//
//  Created by Lucas Santos on 24/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        let settingsVC = SettingsViewController()
        let settingsTabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 1)
        let settingsNavigation = UINavigationController(rootViewController: settingsVC)
        settingsNavigation.tabBarItem = settingsTabBarItem
        settingsNavigation.navigationBar.barStyle = .default
        settingsNavigation.navigationBar.prefersLargeTitles = true
        self.viewControllers?.append(settingsNavigation)

        applyTheme(nil)
        localize()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applyTheme(_:)),
                                               name: UserDefaults.didChangeNotification, object: nil)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func localize() {
        guard let viewControllers = viewControllers else { return }
        viewControllers[0].tabBarItem.title = Localization.moviesTitle
        viewControllers[1].tabBarItem.title = Localization.settingsTitle
    }
}

extension CustomTabBarController: Themed {
    @objc func applyTheme(_ notification: Notification?) {
        let theme = UserDefaults.standard.bool(forKey: SettingsKeys.darkMode) ? AppTheme.darkTheme : AppTheme.lightTheme
        tabBar.barStyle = theme.barStyle
        tabBar.tintColor = theme.barText
    }
}
