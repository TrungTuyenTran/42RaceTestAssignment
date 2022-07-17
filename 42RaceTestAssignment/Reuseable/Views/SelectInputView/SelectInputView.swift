//
//  SelectInputView.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import UIKit

class SelectInputView: UIView {
    // MARK: - IBOutlets
    @IBOutlet private weak var inputTitleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    // MARK: - Private variables
    private var data: [String] = []
    private(set) var selectedDatas: [String] = []
    
    // MARK: - Properties
    @IBInspectable var title: String? {
        get {
            return inputTitleLabel.text
        }
        set {
            inputTitleLabel.text = newValue
        }
    }
    
    @IBInspectable var placeholder: String? {
        get {
            return textField.placeholder
        }
        set {
            textField.placeholder = newValue
        }
    }
    
    // MARK: - Initial
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - IBAction
    @IBAction func tapSelectButton(_ sender: Any) {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            let viewModel = SelectItemVM(items: data, selectedItems: selectedDatas)
            let vc = SelectItemsVC.initViewController(viewModel: viewModel)
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            window.topViewController?.present(navVC, animated: true)
        }
    }
    
    // MARK: - Public functions
    func setData(_ data: [String], selectedData: [String]) {
        self.data = data
        self.updateSelectedData(selectedData)
    }
    
    func updateSelectedData(_ selectedData: [String]) {
        self.selectedDatas = selectedData
        self.setStrings()
    }
    
    // MARK: - Private functions
    private func commonInit() {
        fromNib()
        
        // Margin content left and right
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: bounds.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always
    }
    
    private func setStrings() {
        self.textField.text = ""
        guard !selectedDatas.isEmpty else {
            self.textField.text = "All Categories"
            return
        }
        
        for (index, item) in selectedDatas.enumerated() {
            self.textField.text = (self.textField.text ?? "") + item
            if index != selectedDatas.count - 1 {
                self.textField.text = (self.textField.text ?? "") + ", "
            }
        }
    }

}

extension SelectInputView: SelectItemsVCDelegate {
    func updateSelectedData(selectedData: [String]) {
        self.updateSelectedData(selectedData)
    }
}
