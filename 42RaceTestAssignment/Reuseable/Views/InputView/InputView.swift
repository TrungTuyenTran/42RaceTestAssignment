//
//  InputView.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import UIKit

@IBDesignable
class InputView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var inputTitleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
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
    
    var trimText: String? {
        get {
            return textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        set {
            textField.text = newValue?.trimmingCharacters(in: .whitespacesAndNewlines)
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
    
    // MARK: - Private functions
    private func commonInit() {
        fromNib()
        // Shadow
        addShadow()
        
        // Margin content left and right
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: bounds.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always
        
        textField.delegate = self
    }

}

extension InputView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
