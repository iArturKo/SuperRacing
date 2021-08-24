//
//  SettingsViewController.swift
//  PixelRacing
//
//  Created by Артур Кононович on 1.04.21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var terrainSegmentedControl: UISegmentedControl!
    @IBOutlet weak var speedSegmentedControl: UISegmentedControl!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var terrainLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureSettingsViewController()
    }
    
    func configureSettingsViewController() {
        self.terrainSegmentedControl.setTitle("Plain".localized, forSegmentAt: 0)
        self.terrainSegmentedControl.setTitle("Desert".localized, forSegmentAt: 1)
        self.speedSegmentedControl.setTitle("Normal".localized, forSegmentAt: 0)
        self.speedSegmentedControl.setTitle("Fast".localized, forSegmentAt: 1)
        self.nicknameTextField.text = GameManager.shared.settings.nickName
        self.terrainSegmentedControl.selectedSegmentIndex = GameManager.shared.settings.terrain.rawValue
        self.speedSegmentedControl.selectedSegmentIndex = GameManager.shared.settings.speed.rawValue
        self.settingsLabel.setAttributedText(text: "Settings:".localized)
        self.nicknameLabel.setAttributedText(text: "Nickname:".localized, size: 30)
        self.terrainLabel.setAttributedText(text: "Terrain:".localized, size: 30)
        self.speedLabel.setAttributedText(text: "Speed:".localized, size: 30)
    }
    
    @IBAction func terrainValueChanged(_ sender: UISegmentedControl) {
        if let terrain = TerrainType(rawValue: sender.selectedSegmentIndex) {
            GameManager.shared.setNewTerrain(terrain: terrain)
        }
    }
    
    @IBAction func speedValueChanged(_ sender: UISegmentedControl) {
        if let speed = Speed(rawValue: sender.selectedSegmentIndex) {
            GameManager.shared.setNewSpeed(speed: speed)
        }
    }
    
    @IBAction func nicknameChanged(_ sender: UITextField) {
        if let nickname = sender.text {
            GameManager.shared.setNewNickname(nickName: nickname)
        }
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
