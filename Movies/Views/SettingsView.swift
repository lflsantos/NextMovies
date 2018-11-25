//
//  SettingsView.swift
//  Movies
//
//  Created by Lucas Santos on 24/11/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate: class {
    func enabledDarkMode(_ enabled: Bool)
    func enabledAutoPlay(_ enabled: Bool)
}

final class SettingsView: UIView {

    weak var delegate: SettingsViewDelegate?

    let lblDarkMode: UILabel = {
        let label = UILabel()
        label.text = "Dark Mode"
        label.font = .body
        label.textColor = .body
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let lblAutoPlay: UILabel = {
        let label = UILabel()
        label.text = "Auto Play"
        label.font = .body
        label.textColor = .body
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let swDarkMode: UISwitch = {
        let swDarkMode = UISwitch()
        swDarkMode.translatesAutoresizingMaskIntoConstraints = false
        return swDarkMode
    }()

    let swAutoPlay: UISwitch = {
        let swAutoPlay = UISwitch()
        swAutoPlay.translatesAutoresizingMaskIntoConstraints = false
        return swAutoPlay
    }()

    // MARK: - Super Methods
    init(delegate: SettingsViewDelegate) {
        super.init(frame: UIScreen.main.bounds)
        self.delegate = delegate
        setup()
        applyTheme(nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @objc private func switchDarkMode() {
        delegate?.enabledDarkMode(swDarkMode.isOn)
    }

    @objc private func switchAutoPlay() {
        delegate?.enabledAutoPlay(swAutoPlay.isOn)
    }
}

extension SettingsView: CodeView {
    func setupComponents() {

        self.backgroundColor = .lightBackgroundColor
        addSubview(lblDarkMode)
        addSubview(lblAutoPlay)
        addSubview(swDarkMode)
        addSubview(swAutoPlay)
    }

    func setupConstraints() {
        lblDarkMode.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                         constant: Margin.verticalVeryLarge).isActive = true
        lblDarkMode.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                             constant: Margin.horizontal).isActive = true

        swDarkMode.topAnchor.constraint(equalTo: lblDarkMode.topAnchor).isActive = true
        swDarkMode.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                             constant: -Margin.horizontal).isActive = true

        lblAutoPlay.topAnchor.constraint(equalTo: lblDarkMode.topAnchor,
                                         constant: Margin.verticalVeryLarge).isActive = true
        lblAutoPlay.leadingAnchor.constraint(equalTo: lblDarkMode.leadingAnchor).isActive = true

        swAutoPlay.topAnchor.constraint(equalTo: lblAutoPlay.topAnchor).isActive = true
        swAutoPlay.trailingAnchor.constraint(equalTo: swDarkMode.trailingAnchor).isActive = true
    }

    func setupExtraConfiguration() {
        swDarkMode.addTarget(self, action: #selector(switchDarkMode), for: .valueChanged)
        swAutoPlay.addTarget(self, action: #selector(switchAutoPlay), for: .valueChanged)
    }
}

extension SettingsView: Themed {
    func applyTheme(_ notification: Notification?) {
        let theme = UserDefaults.standard.bool(forKey: SettingsKeys.darkMode) ? AppTheme.darkTheme : AppTheme.lightTheme
        backgroundColor = theme.backgroundColor
        lblAutoPlay.textColor = theme.textColor
        lblDarkMode.textColor = theme.textColor
    }
}
