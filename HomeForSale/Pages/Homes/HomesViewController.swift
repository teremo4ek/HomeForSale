//
//  HomesController.swift
//  HomeForSale
//
//  Created by Yury Bely on 23.05.2022.
//

import UIKit

class HomesViewController: UIViewController {
    
    let homeInfoCellReuseIdentifier = "homeCellReuseIdentifier"
    
    lazy var homesView: UIView = {
        return HomesView(tableView: self.tableView)
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeInfoTableViewCell.self, forCellReuseIdentifier: homeInfoCellReuseIdentifier)
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.homesView)
        self.homesView.autoPinEdgesToSuperviewEdges()
        self.view.layoutIfNeeded()
        
        DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }
}

extension HomesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeInfoCellReuseIdentifier, for: indexPath) as! HomeInfoTableViewCell
        
        
        switch indexPath.row {
            case 0:
                cell.titleLabel.text = "Phone Number"
                cell.descriptionLabel.text = "+234567890"
            case 1:
                cell.titleLabel.text = "Email"
                cell.descriptionLabel.text = "john@doe.co"
            case 2:
                cell.titleLabel.text = "LinkedIn"
                cell.descriptionLabel.text = "45, Walt Disney St.\n37485, Mickey Mouse State"
            default:
                break
            }
        
        
        return cell
    }
    
    
}

extension HomesViewController : UITableViewDelegate {
    
}
