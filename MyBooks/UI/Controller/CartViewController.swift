//
//  CartViewController.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CartProductTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "CartProductTableViewCell")
        
        let _ = CartManager.shared.cartItems.subscribe(onNext: { _ in
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CartProductTableViewCell"
        ) as! CartProductTableViewCell
        cell.item = CartManager.shared.item(at: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return CartManager.shared.itemCount
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 2
    }
}

extension CartViewController: CartProductCellDelegate {
    
    func updateQuantity(_ cell: CartProductTableViewCell, isIncreasing: Bool) {
        CartManager.shared.updateQuantity(book: (cell.item as! CartProduct).book,
                                          isIncreasing: isIncreasing)
    }
    
    func remove(_ cell: CartProductTableViewCell) {
        CartManager.shared.remove(book: (cell.item as! CartProduct).book)
    }
}
