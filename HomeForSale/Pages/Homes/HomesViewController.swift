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
    
    var homesView: HomesView {
        view as! HomesView
    }
    
    
    override func loadView() {
        view = HomesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homesView.tableView.delegate = self
        homesView.tableView.dataSource = self
        homesView.tableView.register(HomeInfoTableViewCell.self, forCellReuseIdentifier: homeInfoCellReuseIdentifier)
        
        viewModel?.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.fetchData()
    }
    
    // MARK -- Update Interface
    private func updateInterface() {
        DispatchQueue.main.async() { [weak self] in
            print("MainTableViewController - updateInterface()")
            self?.homesView.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print("Row: \(indexPath.row)")
        
        let coordinator = HomeDetailCoordinator(presentingController: navigationController)
        coordinator.start()
    }
}

extension HomesViewController : NetworkDataDelegate {
    func onComplition() {
        self.updateInterface()
    }

}
