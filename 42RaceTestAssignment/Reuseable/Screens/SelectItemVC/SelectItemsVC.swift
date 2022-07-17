//
//  SelectItemsVC.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import UIKit

protocol SelectItemsVCDelegate: AnyObject {
    func updateSelectedData(selectedData: [String])
}

class SelectItemsVC: BaseViewController<SelectItemVM> {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: SelectItemsVCDelegate?
    
    override func setupViews() {
        super.setupViews()
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Set", style: .plain, target: self, action: #selector(setTapped))
        
        viewModel?.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @objc private func setTapped() {
        self.delegate?.updateSelectedData(selectedData: viewModel?.selectedItems ?? [])
        self.dismiss(animated: true)
    }
    
    @objc private func cancelTapped() {
        self.dismiss(animated: true)
    }

}

extension SelectItemsVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.items ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectItemCell.cellId, for: indexPath) as! SelectItemCell
        let item = viewModel?.items[indexPath.row] ?? ""
        cell.setData(item: item,
                     check: viewModel?.isSelected(item) ?? false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectItem(index: indexPath.row)
    }
}
