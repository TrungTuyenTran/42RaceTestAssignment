//
//  SelectItemCell.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import UIKit

class SelectItemCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(item: String, check: Bool) {
        self.textLabel?.text = item
        self.accessoryType = check ? .checkmark : .none
    }

}
