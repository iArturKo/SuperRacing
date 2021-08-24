//
//  ScoresViewController.swift
//  PixelRacing
//
//  Created by Артур Кононович on 1.04.21.
//

import UIKit
import RxSwift
import RxCocoa

class ScoresViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.setAttributedText(text: "Scores".localized, size: 50)
        
        GameManager.shared.scores.bind(to: tableView.rx.items(cellIdentifier: "TableViewCell", cellType: TableViewCell.self)) { (row, element, cell) in
            cell.configure(with: element, index: row)
        }
        .disposed(by: disposeBag)
    }
}
