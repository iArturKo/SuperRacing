//
//  CarsCollectionViewCell.swift
//  SuperRacing
//
//  Created by Артур Кононович on 23.08.21.
//

import UIKit

class CarsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CarsCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderColor = isSelected ? UIColor.yellow.cgColor : UIColor.gray.cgColor
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    func configure(with image: UIImage) {
        self.imageView.image = image
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.gray.cgColor
    }

}
