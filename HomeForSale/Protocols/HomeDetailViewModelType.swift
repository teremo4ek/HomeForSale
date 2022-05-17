//
//  HomeDetailViewModelType.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

protocol HomeDetailViewModelType {
    var type: TypeCell { get }
    var id: String { get }
    var askingPrice: Int { get }
    var municipalityArea: String { get }
    var daysSincePublish: Int { get }
    var livingArea: Int { get }
    var numberOfRooms: Int { get }
    var streetAddress: String { get }
    var image: String { get }
    var description: String { get }
    var patio: String { get }
}
