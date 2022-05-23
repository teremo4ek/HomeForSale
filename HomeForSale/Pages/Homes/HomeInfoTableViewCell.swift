//
//  HomeInfoTableViewCell.swift
//  HomeForSale
//
//  Created by Yury Bely on 23.05.2022.
//

import UIKit
import PureLayout

class HomeInfoTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        let titleInsets = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 8)
        titleLabel.autoPinEdgesToSuperviewEdges(with: titleInsets, excludingEdge: .bottom)
        
        let descInsets = UIEdgeInsets(top: 0, left: 16, bottom: 4, right: 8)
        descriptionLabel.autoPinEdgesToSuperviewEdges(with: descInsets, excludingEdge: .top)
        
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 16)
        super.updateConstraints()
    }
}
