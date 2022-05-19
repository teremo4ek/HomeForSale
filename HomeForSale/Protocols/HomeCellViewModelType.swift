//
//  HomeViewCellViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

protocol HomeCellViewModelType: AnyObject {
    var typeCell: TypeCell { get }
    var address: String { get }
    var price: Int { get }
    var livingArea: Int { get }
    var numberOfRooms: Int { get }
    var municipalityArea: String { get }
}
