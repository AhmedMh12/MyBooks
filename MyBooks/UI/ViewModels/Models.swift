//
//  Models.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import Foundation
import AppModel

struct BookCellModel {
    var book: Book
}

class SectionModel {
    
    var headerModel: Any?
    var cellModels: [Any] = []
    var footerModel: Any?
    
    init(headerModel: Any? = nil,
         cellModels: [Any] = [],
         footerModel: Any? = nil) {
        self.headerModel = headerModel
        self.cellModels = cellModels
        self.footerModel = footerModel
    }
}

class FilterCellModel {
    
    var value: String
    var isSelected: Bool
    
    init(value: String,
         isSelected: Bool = false) {
        self.value = value
        self.isSelected = isSelected
    }
}

class HeaderModel {
    
    var type: FilterType
    var isSelected: Bool
    
    init(type: FilterType,
         isSelected: Bool = false) {
        self.type = type
        self.isSelected = isSelected
    }
}
