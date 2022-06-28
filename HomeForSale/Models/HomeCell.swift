//
//  HomeData.swift
//  HomeForSale
//
//  Created by Yury Bely on 18.05.2022.
//

import Foundation
import UIKit

class HomeCell {
    let type, id: String
    let askingPrice: Int?
    let municipality: String?
    let area: String
    let daysSincePublish, livingArea, numberOfRooms: Int?
    let streetAddress: String?
    let monthlyFee: Int?
    let ratingFormatted: String?
    let averagePrice: Int?
    let imageUrl: String

    var imageData: Data?
    var image: UIImage?
    var imageDownloaded: Bool {
        didSet {

        }
    }

    init?(homeItem: HomeItm) {
        type = homeItem.type
        id = homeItem.id
        askingPrice = homeItem.askingPrice
        municipality = homeItem.municipality
        area = homeItem.area
        daysSincePublish = homeItem.daysSincePublish
        livingArea = homeItem.livingArea
        numberOfRooms = homeItem.numberOfRooms
        streetAddress = homeItem.streetAddress
        monthlyFee = homeItem.monthlyFee
        ratingFormatted = homeItem.ratingFormatted
        averagePrice = homeItem.averagePrice
        imageUrl = homeItem.image

        imageDownloaded = false
        imageData = nil
    }
}
