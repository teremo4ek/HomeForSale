//
//  HomeDetail.swift
//  HomeForSale
//
//  Created by Yury Bely on 25.05.2022.
//

import Foundation

struct HomeDetail {

    let type, id: String
    let askingPrice: Int
    let municipality, area: String
    let daysSincePublish, livingArea, numberOfRooms: Int
    let streetAddress: String
    let homeDescription, patio: String

    var imageDownloaded: Bool
    var imageData: Data?

    init?(homeDescription: HomeDescription) {
        type = homeDescription.type
        id = homeDescription.id
        askingPrice = homeDescription.askingPrice
        municipality = homeDescription.municipality
        area = homeDescription.area
        daysSincePublish = homeDescription.daysSincePublish
        livingArea = homeDescription.livingArea
        numberOfRooms = homeDescription.numberOfRooms
        streetAddress = homeDescription.streetAddress
        self.homeDescription = homeDescription.homeDescription
        patio = homeDescription.patio

        imageDownloaded = false
        imageData = nil
    }

}
