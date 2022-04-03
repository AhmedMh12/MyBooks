//
//  BookListViewModel.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import Foundation
import AppModel
import RxSwift
import RxCocoa

typealias DataHandler = () -> Void

let disposableBag = DisposeBag()

class BookListViewModel {
    
    var items: [BookCellModel] = []
    var searchItems = BehaviorRelay<[BookCellModel]>(value: [])
    var reloadHandler: DataHandler = { }
    private var isAscending: Bool = false
    var filterModel = BookFilterViewModel()
    
    var itemCount: Int {
        return self.searchItems.value.count
    }
    
    init() {
        let _ = self.searchItems.asObservable().subscribe(onNext: { _ in
            self.reloadHandler()
        }).disposed(by: disposableBag)
    }
    
    func item(_ indexPath: IndexPath) -> BookCellModel {
        return self.searchItems.value[indexPath.row]
    }
    
    func fetchItems(completion: @escaping (_ error: Error?) -> Void) {
        NetworkClient.getBeerListOffline { [weak self] (list, error) in
            if let error = error {
                completion(error)
            } else {
                self?.configureModels(list: list)
                self?.configureFilters(list: list)
                completion(nil)
            }
        }
    }
    
    private func configureModels(list: [Book]) {
        self.items = list.map { BookCellModel(book: $0) }
        self.searchItems.accept(self.items)
    }
}

// FILTER
extension BookListViewModel {
    
    func configureFilters(list: [Book]) {
        self.filterModel = BookFilterViewModel(list: list)
    }
    
    func clearFilters() {
        self.resetData()
    }
    
    func applyFilters(filters: [FilterType: [String]]) {
        let filterItems = self.items.filter { item -> Bool in
            var acceptArray: [Bool] = []
            for (key, value) in filters {
                switch key {
                case .title:
                    acceptArray.append(value.isEmpty ? true : value.contains(item.book.title ?? ""))
                case .synopsis:
                    acceptArray.append(value.isEmpty ? true : value.contains(String(item.book.synopsis ?? "")))
                case .price:
                    acceptArray.append(value.isEmpty ? true : value.contains(String(item.book.price ?? 0)))
                }
            }
            return acceptArray.reduce(true, { (result, value) -> Bool in
                return result && value
            })
        }
        
        self.searchItems.accept(filterItems)
          
    }
}


// SEARCH
extension BookListViewModel {
    
    func filterSearch(searchText: String) {
        if searchText.isEmpty {
            self.searchItems.accept(self.items)
        } else {
            let value = self.items.filter {
                $0.book.title?.lowercased().contains(searchText.lowercased()) as! Bool
            }
            self.searchItems.accept(value)
        }
    }
    
    func resetData() {
        self.searchItems.accept(self.items)
    }
}

// SORT
extension BookListViewModel {
    
    func sortItems() {
      /*  self.isAscending = !self.isAscending
        let value = self.searchItems.value.sorted(by: {
            let order = $0.book.price.compare($1.book.price,
                                            options: .numeric)
            return self.isAscending ?
                   order == .orderedAscending :
                   order == .orderedDescending
        })
        self.searchItems.accept(value)*/
    }
}

