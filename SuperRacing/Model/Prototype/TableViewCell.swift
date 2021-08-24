//
//  TableViewCell.swift
//  PixelRacing
//
//  Created by Артур Кононович on 1.06.21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nicknameLabel.text = nil
        self.scoreLabel.text = nil
        self.dateLabel.text = nil
    }

    func configure(with object: Score, index: Int) {
        self.nicknameLabel.font = UIFont(name: "UpheavalPro", size: 25)
        self.nicknameLabel.text = "\(index + 1). " + object.nickname
        self.scoreLabel.font = UIFont(name: "UpheavalPro", size: 25)
        self.scoreLabel.text = String(object.score)
        self.dateLabel.font = UIFont(name: "UpheavalPro", size: 20)
        self.dateLabel.text = object.date
    }

}
