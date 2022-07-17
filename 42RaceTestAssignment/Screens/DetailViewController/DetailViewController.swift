//
//  DetailViewController.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import UIKit

class DetailViewController: BaseViewController<DetailVM> {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var businessNameLabel: UILabel!
    @IBOutlet private weak var businessRatingLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var categoriesLabel: UILabel!
    @IBOutlet private weak var isOpenLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    
    override func setupViews() {
        super.setupViews()
        
        viewModel?.reloadData = { [weak self] in
            self?.imageView.getOrDownloadImage(from: self?.viewModel?.item.image_url ?? "")
            self?.businessNameLabel.text = self?.viewModel?.item.name ?? ""
            self?.businessRatingLabel.text = String(format: "%.1f", (self?.viewModel?.item.rating ?? 0.0))
            self?.addressLabel.text = self?.viewModel?.item.location.addressString
            self?.categoriesLabel.text = self?.viewModel?.getCategoryString() ?? ""
            self?.isOpenLabel.text = (self?.viewModel?.item.is_closed ?? true) ? "Closed" : "Opening"
            self?.phoneLabel.text = self?.viewModel?.item.display_phone ?? ""
        }
        
        viewModel?.refreshItem()
    }

    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
