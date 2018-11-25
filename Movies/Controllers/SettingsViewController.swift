//
//  SettingsViewController.swift
//  Movies
//
//  Created by Lucas Santos on 24/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Properties
    var userDefaults = UserDefaults.standard
    var settingsView: SettingsView?

    // MARK: - Super Methods
    override func loadView() {
        settingsView = SettingsView(delegate: self)
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        if let settingsView = settingsView {
            settingsView.swDarkMode.setOn(userDefaults.bool(forKey: SettingsKeys.darkMode),
                                           animated: false)
            settingsView.swAutoPlay.setOn(userDefaults.bool(forKey: SettingsKeys.autoPlay),
                                           animated: false)
        }
    }
}

extension SettingsViewController: SettingsViewDelegate {
    func enabledDarkMode(_ enabled: Bool) {
        userDefaults.set(enabled, forKey: SettingsKeys.darkMode)
    }

    func enabledAutoPlay(_ enabled: Bool) {
        userDefaults.set(enabled, forKey: SettingsKeys.autoPlay)
    }
}
