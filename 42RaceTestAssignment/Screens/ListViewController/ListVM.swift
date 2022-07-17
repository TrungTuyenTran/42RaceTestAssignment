//
//  ListVM.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import Foundation
import Repository

class ListVM: ViewModelType {
    
    private var name: String
    private var categories: String
    private var location: String
    private var offset: Int = 0
    private var itemRepo: ItemRepositoryProtocol = ItemRepository()
    private var total: Int = 0
    
    private(set) var data: [ResponseItemModel] = []
    
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    
    init(name: String, categories: String, location: String) {
        self.name = name
        self.categories = categories
        self.location = location
    }
    
    func search(loadmore: Bool = false) {
        if !loadmore {
            offset = 0
        }
        itemRepo.search(name: name, categories: categories, offset: offset, location: location) { [weak self] pagingResponse, error in
            guard let self = self else { return }
            if let pagingResponse = pagingResponse {
                self.total = pagingResponse.total
                self.data.append(contentsOf: pagingResponse.businesses)
                self.offset = self.data.count
                self.reloadData?()
            }
            
            if let error = error {
                self.showError?(error)
            }
        }
    }
}
