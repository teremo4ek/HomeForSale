//
//  HomesController.swift
//  HomeForSale
//
//  Created by Yury Bely on 23.05.2022.
//

import UIKit

class HomesViewController: UIViewController {
    
    private let homeInfoCellReuseIdentifier = "homeCellReuseIdentifier"
    
    var viewModel: HomesViewModel!
    
    lazy var homesView: UIView = {
        return HomesView(tableView: self.tableView)
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeInfoTableViewCell.self, forCellReuseIdentifier: homeInfoCellReuseIdentifier)
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.homesView)
        self.homesView.autoPinEdgesToSuperviewEdges()
        self.view.layoutIfNeeded()
        
        viewModel?.delegate = self
        viewModel?.fetchData()
        
    }
    
    // MARK -- Update Interface
    private func updateInterface() {
        DispatchQueue.main.async() { [weak self] in
            print("MainTableViewController - updateInterface()")
            self?.tableView.reloadData()
        }
    }
}

extension HomesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeInfoCellReuseIdentifier, for: indexPath) as! HomeInfoTableViewCell

        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel

        return cell
    }
}

extension HomesViewController : UITableViewDelegate {
    
}

extension HomesViewController : NetworkDataDelegate {
    func onComplition() {
        self.updateInterface()
    }

}
