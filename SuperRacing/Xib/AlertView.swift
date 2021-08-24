//
//  AlertView.swift
//  SuperRacing
//
//  Created by Артур Кононович on 23.08.21.
//

import UIKit

protocol AlertViewDelegate: AnyObject {
    func menuButtonPressed()
    func retryButtonPressed()
}

class AlertView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var retryButton: UIButton!
    
    weak var delegate: AlertViewDelegate?
    
    class func instanceFromNib() -> AlertView {
        if let alertView = UINib(nibName: "AlertView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? AlertView {
            alertView.menuButton.setTitle("Menu".localized, for: .normal)
            alertView.retryButton.setTitle("Retry".localized, for: .normal)
            return alertView
        } else {
            return AlertView()
        }
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        delegate?.menuButtonPressed()
    }
    
    @IBAction func retryButtonPressed(_ sender: UIButton) {
        delegate?.retryButtonPressed()
    }
}
