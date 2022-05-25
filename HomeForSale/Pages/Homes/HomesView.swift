//
//  HomesView.swift
//  HomeForSale
//
//  Created by Yury Bely on 23.05.2022.
//

import UIKit
import PureLayout

class HomesView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView(forAutoLayout: ())
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = true
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
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
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
}
