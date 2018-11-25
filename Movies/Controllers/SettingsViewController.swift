//
//  SettingsViewController.swift
//  Movies
//
//  Created by Lucas Santos on 24/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    typealias CustomView = SettingsView

    // MARK: - Super Methods
    override func loadView() {
        view = CustomView(delegate: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0,
                                                          width: UIScreen.main.bounds.size.width, height: 44))
        navigationBar.barStyle = .black
        navigationBar.prefersLargeTitles = true
        let navigationTitle = UINavigationItem(title: "Settings")
        navigationBar.setItems([navigationTitle], animated: false)
        self.view.addSubview(navigationBar)
    }
}

extension SettingsViewController: SettingsViewDelegate {
    func enabledDarkMode(_ enabled: Bool) {

    }

    func enabledAutoPlay(_ enabled: Bool) {

    }
}
