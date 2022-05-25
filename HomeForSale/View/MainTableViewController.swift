//
//  MainTableViewController.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import UIKit

class MainTableViewController: UITableViewController {

    var viewModel: MainTableViewModelType?
    var networkDataManager: NetworkDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        networkDataManager = NetworkDataManager()
        viewModel = MainTableViewModel(delegate: self, networkDataManager: networkDataManager!)
        
        //Todo (coanfigurator )
        let xibBtn = UIBarButtonItem(title: "Btn", style: .plain, target: self, action: #selector(btnPressed))
        let xibLbl = UIBarButtonItem(title: "Lbl", style: .plain, target: self, action: #selector(lblPressed))
        let detail = UIBarButtonItem(title: "Detail", style: .plain, target: self, action: #selector(detailPressed))
        navigationItem.rightBarButtonItems = [xibBtn, xibLbl, detail ]
        
        viewModel?.fetchData()
    }
    
    @objc private func btnPressed() {
        let coordinator = XibButtonViewCoordinator(presentingController: navigationController)
        coordinator.start()
    }
    
    @objc private func lblPressed() {
        let coordinator = XibLabelViewCoordinator(presentingController: navigationController)
        coordinator.start()
    }
    
    @objc private func detailPressed() {
        let coordinator = DetailScreenCoordinator(presentingController: navigationController)
        coordinator.start()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel?.numberOfRows() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)

        tableViewCell.viewModel = cellViewModel

        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = viewModel else { return }
        
        if identifier == "detailSegue" {
            if let dvc = segue.destination as? HomeDetailViewController1 {
                dvc.viewModel = viewModel.viewModelForSelectedRow()
            }
        }
    }
    
    // MARK -- table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    // MARK -- Update Interface 
    private func updateInterface() {
        DispatchQueue.main.async() { [weak self] in
            print("MainTableViewController - updateInterface()")
            self?.tableView.reloadData()
        }
    }
}


extension MainTableViewController : MainTableNetworkDataDelegate {
    func onComplition() {
        self.updateInterface()
    }

}

