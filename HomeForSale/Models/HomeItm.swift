//
//  HomeList.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

// MARK: - HomeList
struct HomeList: Codable {
    let items: [HomeItm]
}

// MARK: - Home
struct HomeItm: Codable {
    let type, id: String
    let askingPrice: Int?
    let municipality: String?
    let area: String
    let daysSincePublish, livingArea, numberOfRooms: Int?
    let streetAddress: String?
    let image: String
    let monthlyFee: Int?
    let ratingFormatted: String?
    let averagePrice: Int?
}

// MARK: - HomeDescription
struct HomeDescription: Codable {
    let type, id: String
    let askingPrice: Int
    let municipality, area: String
    let daysSincePublish, livingArea, numberOfRooms: Int
    let streetAddress: String
    let image: String
    let homeDescription, patio: String

    enum CodingKeys: String, CodingKey {
        case type, id, askingPrice, municipality, area, daysSincePublish, livingArea, numberOfRooms, streetAddress, image
        case homeDescription = "description"
        case patio
    }
}
