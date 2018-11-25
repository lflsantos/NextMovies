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

        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let settingsVC = SettingsViewController()
        let settingsTabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 1)
        settingsVC.tabBarItem = settingsTabBarItem
        self.viewControllers?.append(settingsVC)
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

extension CustomTabBarController: UITabBarControllerDelegate {

}
