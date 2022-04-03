//
//  FilterTableViewCell.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import UIKit

class FilterTableViewCell: TableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    override func configure(_ item: Any?) {
        guard let model = item as? FilterCellModel else { return }
        self.filterLabel.text = model.value
        self.filterLabel.textColor = model.isSelected ? .blue  : .black
    }
}
