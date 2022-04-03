//
//  CartProductTableViewCell.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import UIKit

protocol CartProductCellDelegate: class {
    func updateQuantity(_ cell: CartProductTableViewCell, isIncreasing: Bool)
    func remove(_ cell: CartProductTableViewCell)
}

class CartProductTableViewCell: TableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLbel: UILabel!
    
    @IBOutlet weak var bookImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func configure(_ item: Any?) {
        guard let model = item as? CartProduct else { return }
        self.titleLabel.text = model.book.title
        self.synopsisLabel.text = model.book.synopsis
        if let price = model.book.price {
            self.priceLbel.text = "price: \(price) euro"
        }
        self.countLabel.text = String(model.quantity)
        let ImageUrl = URL(string: model.book.cover ?? "")!
        self.bookImage.load(url: ImageUrl)
    }
    
    @IBAction func removeAction(_ sender: UIButton) {
        (self.delegate as? CartProductCellDelegate)?.remove(self)
    }
    
    @IBAction func incAction(_ sender: UIButton) {
        (self.delegate as? CartProductCellDelegate)?.updateQuantity(self,
                                                                    isIncreasing: true)
    }
    
    @IBAction func decAction(_ sender: UIButton) {
        (self.delegate as? CartProductCellDelegate)?.updateQuantity(self,
                                                                    isIncreasing: false)
    }
}
