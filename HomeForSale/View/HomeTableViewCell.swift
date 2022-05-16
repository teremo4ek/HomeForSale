//
//  HomeViewCellTableViewCell.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    weak var viewModel: HomeCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            fullNameLabel.text = viewModel.id
            ageLabel.text = viewModel.area
        }
    }
}
