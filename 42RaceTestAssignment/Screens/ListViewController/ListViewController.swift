//
//  ListViewController.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 16/07/2022.
//

import UIKit

class ListViewController: BaseViewController<ListVM> {
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func setupViews() {
        super.setupViews()
        self.title = "Results"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        viewModel?.reloadData = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.search()
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListItemCell.cellId, for: indexPath) as! ListItemCell
        let item = viewModel?.data[indexPath.row]
        cell.setData(imageUrl: item?.image_url ?? "",
                     name: item?.name ?? "",
                     address: item?.location.addressString ?? "",
                     rating: item?.rating ?? 0.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = viewModel?.data.count, count - 5 > 0 else { return }
        if indexPath.row == count - 5 {
            self.viewModel?.search(loadmore: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel?.data[indexPath.row] else { return }
        let vc = DetailViewController.initViewController(viewModel: DetailVM(item: item))
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

