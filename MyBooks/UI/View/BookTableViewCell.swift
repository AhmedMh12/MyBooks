//
//  BookTableViewCell.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import UIKit

protocol BookTableViewCellDelegate: class {
    func didTapAddButton(cell: BookTableViewCell)
}

class BookTableViewCell: TableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var priceLbel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func configure(_ item: Any?) {
        guard let model = item as? BookCellModel else { return }
        self.titleLabel.text = model.book.title
        self.synopsisLabel.text = model.book.synopsis
        self.priceLbel.text = model.book.title
        let ImageUrl = URL(string: model.book.cover ?? "")!
        self.bookImage.load(url: ImageUrl)
    }
    
    @IBAction func addAction(_ sender: Any) {
        (self.delegate as? BookTableViewCellDelegate)?.didTapAddButton(cell: self)
    }
}
