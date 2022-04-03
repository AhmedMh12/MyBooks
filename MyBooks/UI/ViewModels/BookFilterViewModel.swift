//
//  BookFilterViewModel.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import Foundation
import AppModel

enum FilterType: String {
    case title = "title"
    case price = "price"
    case synopsis = "synopsis"
}

class BookFilterViewModel {
    
    var sections: [SectionModel] = []
    var reloadHandler: DataHandler = { }
    var filters: [FilterType: [String]] = [:]
    
    init(list: [Book] = []) {
        self.configure(list: list)
    }
    
    func configure(list: [Book]) {
        
        let abvDictionary = list.reduce(into: [String: Int]()) { (dictionary, model) in
            let type = String(model.price ?? 0).isEmpty ? "0.00" : String(model.price!)
            dictionary[type] = 0
        }
        
        let ouncesDictionary = list.reduce(into: [String: String]()) { (dictionary, model) in
            let type = model.title
            dictionary[type ?? ""] = ""
        }
        
        let styleDictionary = list.reduce(into: [String: String]()) { (dictionary, model) in
            let synopsis = model.synopsis
            dictionary[synopsis ?? ""] = ""
        }
        
        let abvCellModels = abvDictionary.map { FilterCellModel(value: $0.key) }
        let ouncesCellModels = ouncesDictionary.map { FilterCellModel(value: $0.key) }
        let styleCellModels = styleDictionary.map { FilterCellModel(value: $0.key) }
        
        self.sections = [
            SectionModel(headerModel: HeaderModel(type: .title),
                         cellModels: styleCellModels),
            SectionModel(headerModel: HeaderModel(type: .price),
                         cellModels: ouncesCellModels),
            SectionModel(headerModel: HeaderModel(type: .synopsis),
                         cellModels: abvCellModels)
        ]
    }
}

extension BookFilterViewModel {
    
    func item(at indexPath: IndexPath) -> FilterCellModel {
        return self.sections[
            indexPath.section
        ].cellModels[
            indexPath.row
        ] as! FilterCellModel
    }
    
    func items(at indexPath: IndexPath) -> [FilterCellModel] {
        return self.sections[
            indexPath.section
        ].cellModels as! [FilterCellModel]
    }
    
    func itemCount(at section: Int) -> Int {
        return self.sections[
            section
        ].cellModels.count
    }
    
    var sectionCount: Int {
        return self.sections.count
    }
    
    func sectionModel(at section: Int) -> Any? {
        return self.sections[
            section
        ].headerModel
    }
}

// APPLY and CLEAR
extension BookFilterViewModel {
    
    func clearFilters() {
        self.sections.forEach {
            $0.cellModels.forEach { model in
                (model as? FilterCellModel)?.isSelected = false
            }
        }
        self.filters.removeAll()
        self.reloadHandler()
    }
    
    func updateFilter(at indexPath: IndexPath) {
        
        guard let sectionModel = self.sectionModel(at: indexPath.section) as? HeaderModel else { return }
        
        let cellModel = self.item(at: indexPath)
        cellModel.isSelected = !cellModel.isSelected
        
        if cellModel.isSelected {
            if let _ = self.filters[sectionModel.type] {
                self.filters[sectionModel.type]?.append(cellModel.value)
            } else {
                self.filters[sectionModel.type] = [cellModel.value]
            }
        } else {
            guard let values = self.filters[sectionModel.type],
                  let index = values.index(where: {
                  $0 == cellModel.value
              }) else { return }
            self.filters[sectionModel.type]?.remove(at: index)
        }
        print("UPDATED FILTERS : \(self.filters)")
    }
}

