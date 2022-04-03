//
//  FilterHeaderView.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import UIKit

protocol FilterHeaderViewDelegate: class {
    func didSelect(headerView: FilterHeaderView)
}

class FilterHeaderView: TableHeaderFooterView {

    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure(_ item: Any?) {
        guard let model = item as? HeaderModel else { return }
        self.titleLabel.text = model.type.rawValue
    }
    
    @IBAction func tapAction(_ sender: Any) {
        guard let model = item as? HeaderModel else { return }
        model.isSelected = !model.isSelected
        (self.delegate as? FilterHeaderViewDelegate)?.didSelect(headerView: self)
    }
}
