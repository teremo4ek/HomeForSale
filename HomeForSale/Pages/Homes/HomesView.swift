//
//  HomesView.swift
//  HomeForSale
//
//  Created by Yury Bely on 23.05.2022.
//

import UIKit
import PureLayout

class HomesView: UIView {

    var tableView: UITableView!
    
    init(tableView: UITableView) {
        super.init(frame: .zero)
        self.tableView = tableView
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.autoPinEdgesToSuperviewEdges(with: .zero)
    }
    
}
