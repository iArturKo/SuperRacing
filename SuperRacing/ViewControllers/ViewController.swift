//
//  ViewController.swift
//  PixelRacing
//
//  Created by Артур Кононович on 1.04.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var chooseCar: UIButton!
    @IBOutlet weak var scores: UIButton!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var buttonStack: UIStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.label.setAttributedText(text: "SUPER RACING", size: 100)
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(identifier: "GameViewController") as? GameViewController else {
            return
        }
        controller.terrain = GameManager.shared.getTerrain()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func ChooseCarButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(identifier: "ChooseCarViewController") as? ChooseCarViewController else {
            return
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func scoresButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(identifier: "ScoresViewController") as? ScoresViewController else {
            return
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(identifier: "SettingsViewController") as? SettingsViewController else {
            return
        }
        self.present(controller, animated: true, completion: nil)
    }
}

