//
//  ChooseCarViewController.swift
//  SuperRacing
//
//  Created by Артур Кононович on 18.08.21.
//

import UIKit

class ChooseCarViewController: UIViewController {

    @IBOutlet weak var carsCollectionView: UICollectionView!
    @IBOutlet weak var carsLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.carsLabel.setAttributedText(text: "Cars:".localized)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.carsCollectionView.selectItem(at: GameManager.shared.getCurrentIndexPath(), animated: false, scrollPosition: .bottom)
    }
}

extension ChooseCarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameManager.shared.carImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarsCollectionViewCell.identifier, for: indexPath) as? CarsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let image = UIImage(named: GameManager.shared.carImageArray[indexPath.item]) {
            cell.configure(with: image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = (collectionView.frame.width - 40) / 3
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GameManager.shared.setNewCar(indexPath: indexPath)
    }
    
}

