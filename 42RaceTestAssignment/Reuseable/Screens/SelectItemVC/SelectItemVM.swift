//
//  SelectItemVM.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import Foundation

class SelectItemVM: ViewModelType {
    private(set) var items: [String]
    private(set) var selectedItems: [String]
    
    var reloadData: (() -> Void)?
    
    init(items: [String], selectedItems: [String]) {
        self.items = items
        self.selectedItems = selectedItems
    }
    
    func isSelected(_ item: String) -> Bool {
        return selectedItems.contains(item)
    }
    
    func selectItem(index: Int) {
        let value = items[index]
        if selectedItems.contains(value) {
            selectedItems.removeAll(where: { $0 == items[index]})
        } else {
            selectedItems.append(value)
        }
        reloadData?()
    }
    
}
