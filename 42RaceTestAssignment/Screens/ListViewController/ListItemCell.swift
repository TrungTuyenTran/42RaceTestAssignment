//
//  ListItemCell.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import UIKit

class ListItemCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var businessImageView: UIImageView!
    @IBOutlet private weak var businessNameLabel: UILabel!
    @IBOutlet private weak var businessAddressLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.addShadow(opacity: 0.1, cornerRadius: 16)
    }

    func setData(imageUrl: String,
                 name: String,
                 address: String,
                 rating: Double) {
        businessImageView.getOrDownloadImage(from: imageUrl)
        businessNameLabel.text = name
        businessAddressLabel.text = address
        ratingLabel.text = String(format: "%.1f", rating)
    }
}
