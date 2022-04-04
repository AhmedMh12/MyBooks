//
//  CollectionViewCell.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }
    
    weak var delegate: NSObjectProtocol? = nil
    
    func configure(_ item: Any?) {
        
    }
    
}

class CollectionReusableView: UICollectionReusableView {
    
    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }
    
    weak var delegate: NSObjectProtocol? = nil
    
    func configure(_ item: Any?) {
        
    }
    
}
