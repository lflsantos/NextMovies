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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applyTheme(_:)),
                                               name: UserDefaults.didChangeNotification, object: nil)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Methods

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension CustomTabBarController: Themed {
    @objc func applyTheme(_ notification: Notification?) {
        let theme = UserDefaults.standard.bool(forKey: SettingsKeys.darkMode) ? AppTheme.darkTheme : AppTheme.lightTheme
        tabBar.barStyle = theme.barStyle
        tabBar.tintColor = theme.barText
    }
}
