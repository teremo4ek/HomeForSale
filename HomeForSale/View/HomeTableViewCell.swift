//
//  HomeViewCellTableViewCell.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet private var imageOfHouse: UIImageView!
    
    @IBOutlet private weak var address: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var livingArea: UILabel!
    @IBOutlet private weak var numberOfRooms: UILabel!
    @IBOutlet private weak var municipalityArea: UILabel!
    
    weak var viewModel: HomeCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            address.text = viewModel.address
            price.text = String(viewModel.price)
            livingArea.text = String(viewModel.livingArea)
            numberOfRooms.text = String(viewModel.numberOfRooms)
            municipalityArea.text = viewModel.municipalityArea
        }
    }
}
