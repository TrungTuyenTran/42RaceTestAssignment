//
//  DetailVM.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import Repository

class DetailVM: ViewModelType {
    
    private(set) var item: ResponseItemModel
    
    var reloadData: (() -> Void)?
    
    init(item: ResponseItemModel) {
        self.item = item
    }
    
    func refreshItem() {
        reloadData?()
    }
    
    func getCategoryString() -> String {
        var result = ""
        for (index, itemString) in  item.categories.map( { $0.title } ).enumerated() {
            result += itemString
            if index !=  item.categories.map( { $0.title } ).count - 1 {
                result += ", "
            }
        }
        return result
    }
}
