//
//  SearchVM.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import Foundation
import Repository

class SearchVM: ViewModelType {
    
    private var repository: CategoryRepositoryProtocol = CategoryRepository()
    
    var showError: ((String) -> Void)?
    var goToListVC: ((_ name: String, _ categories: String, _ location: String) -> Void)?
    var setCategories: (() -> Void)?
    
    func search(name: String, categories: String, location: String) {
        if name.isEmpty && categories.isEmpty && location.isEmpty {
            showError?("Please input least a value")
            return
        }
        
        if location.isEmpty {
            showError?("Please input location")
            return
        }
        
        goToListVC?(name, categories, location)
    }
    
    func getCategories() {
        guard let _ = UserDefaultInfo.categories else {
            repository.listCateogry { [weak self] categories, error in
                if let error = error {
                    self?.showError?(error)
                }
                
                if let categories = categories {
                    UserDefaultInfo.categories = categories
                    self?.setCategories?()
                }
            }
            return
        }
        self.setCategories?()
    }
}
