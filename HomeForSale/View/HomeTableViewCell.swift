//
//  HomeViewCellTableViewCell.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet var imageOfHouse: UIImageView!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var livingArea: UILabel!
    @IBOutlet weak var numberOfRooms: UILabel!
    @IBOutlet weak var municipalityArea: UILabel!
    
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
