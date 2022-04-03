//
//  CartManager.swift
//  MyBooks
//
//  Created by MacBook Pro on 31/3/2022.
//

import Foundation
import AppModel
import RxSwift
import RxCocoa

struct CartProduct {
    var book: Book
    var quantity: Int
}

class CartManager {
    
    static let shared = CartManager()
    
    private init() { }
    
    private(set) var cartItems = BehaviorRelay<[CartProduct]>(value: [])
    
    var itemCount: Int {
        return self.cartItems.value.count
    }
    
    func item(at index: Int) -> CartProduct {
        return self.cartItems.value[index]
    }
    
    func add(book: Book) {
        var value = self.cartItems.value
        if let index = self.cartItems.value.index(where: { $0.book.isbn == book.isbn }) {
            value[index].quantity += 1
        } else {
            value.append(CartProduct(book: book, quantity: 1))
        }
        self.cartItems.accept(value)
    }
    
    func remove(book: Book) {
        guard let index = self.cartItems.value.index(where: {
            $0.book.isbn == book.isbn
        }) else { return }
        var value = self.cartItems.value
        value.remove(at: index)
        self.cartItems.accept(value)
    }
    
    func updateQuantity(book: Book, isIncreasing: Bool = true) {
        guard let index = self.cartItems.value.index(where: {
            $0.book.isbn == book.isbn
        }) else { return }
        
        var value = self.cartItems.value
        
        if isIncreasing {
            // CASE QUANTITY INCREASING
            value[index].quantity += 1
        } else {
            // CASE QUANTITY DECREASING
            if value[index].quantity == 1 {
                value.remove(at: index)
            } else {
                value[index].quantity -= 1
            }
        }
        
        self.cartItems.accept(value)
    }
}
