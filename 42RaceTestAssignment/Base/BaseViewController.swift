//
//  BaseViewController.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import UIKit

protocol ViewModelType: AnyObject {}

class BaseViewController<T: ViewModelType>: UIViewController {
    
    private(set) var viewModel: T?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // Bind ViewModel
    func bind(_ viewModel: T) {
        self.viewModel = viewModel
    }
    
    // Setup for UI
    func setupViews() {
        // Notification Hide/Show Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    // Show Error
    func showError(_ error: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertVC.addAction(okAction)
            self.navigationController?.present(alertVC, animated: true)
        }
    }
    
    
    // MARK: - Handle notification selectors
    @objc func keyboardWillShow(notification: Notification) {}
    
    @objc func keyboardWillHide(notification: Notification) {}
    
    static func initViewController(storyboard: Storyboard = .main, viewModel: T) -> Self {
        let viewController = storyboard.instance.instantiateViewController(withIdentifier: String(describing: self)) as! Self
        viewController.bind(viewModel)
        return viewController
    }

}
