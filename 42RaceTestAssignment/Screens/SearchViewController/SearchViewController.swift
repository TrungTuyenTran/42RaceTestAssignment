//
//  SearchViewController.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 16/07/2022.
//

import UIKit

class SearchViewController: BaseViewController<SearchVM> {
    
    // IBOutlets
    @IBOutlet weak var nameView: InputView!
    @IBOutlet weak var addressView: InputView!
    @IBOutlet weak var cityView: InputView!
    @IBOutlet weak var zipCodeView: InputView!
    @IBOutlet weak var categoriesView: SelectInputView!
    
    override func setupViews() {
        super.setupViews()
        hideKeyboardWhenTappedAround()
        
        viewModel?.showError = { [weak self] error in
            self?.showError(error)
        }
        viewModel?.goToListVC = { [weak self] name, categories, location in
            let vc = ListViewController.initViewController(viewModel: ListVM(name: name, categories: categories, location: location))
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        viewModel?.setCategories = {  [weak self] in
            DispatchQueue.main.async {
                var categoryTitles: [String] = []
                let userdefaultCategory: [String] = (UserDefaultInfo.categories ?? []).map { $0.title }
                categoryTitles.append(contentsOf: userdefaultCategory)
                self?.categoriesView.setData(categoryTitles,
                                             selectedData: [])
            }
        }
        viewModel?.getCategories()
    }

    // Handle Show Keyboard
    override func keyboardWillShow(notification: Notification) {
        super.keyboardWillShow(notification: notification)
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.transform = CGAffineTransform.init(translationX: 0, y: -keyboardSize.height)
        }
    }
    
    // Handle Show Keyboard
    override func keyboardWillHide(notification: Notification) {
        self.view.transform = CGAffineTransform.identity
    }
    
    // Handle Tap Search Button
    @IBAction func tapSearch(_ sender: Any) {
        self.view.endEditing(true)
        viewModel?.search(name: name(), categories: categories(), location: location())
    }
    
    // MARK: - handle data from UI
    func name() -> String {
        return nameView.trimText ?? ""
    }
    
    func location() -> String {
        var result = ""
        if !(addressView.trimText?.isEmpty ?? true) {
            result += addressView.trimText ?? ""
        }
        
        if !(cityView.trimText?.isEmpty ?? true) {
            result += cityView.trimText ?? ""
        }
        
        if !(zipCodeView.trimText?.isEmpty ?? true) {
            result += zipCodeView.trimText ?? ""
        }
        return result
    }
    
    func categories() -> String {
        var selected = categoriesView.selectedDatas
        selected.removeAll(where: { $0 == "All Categories" })
        var result = ""
        for (index, item) in selected.enumerated() {
            let alias = UserDefaultInfo.categories?.first(where: { $0.title == item })?.alias ?? ""
            result += alias
            if index != selected.count - 1 {
                result += ","
            }
        }
        return result
    }
    
}
