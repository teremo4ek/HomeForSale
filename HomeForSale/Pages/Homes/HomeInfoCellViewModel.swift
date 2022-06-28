//
//  HomeInfoCellViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 24.05.2022.
//

import Foundation
import UIKit

final class HomeInfoCellViewModel {
    private var home: HomeCell

    init(home: HomeCell) {
        self.home = home
    }

    var typeCell: TypeCell {
        return .Property
    }

    var address: String {
        return home.streetAddress ?? "Default"
    }

    var price: Int {
        return home.askingPrice ?? 0
    }

    var livingArea: Int {
        return home.livingArea ?? 0
    }

    var numberOfRooms: Int {
        return home.numberOfRooms ?? 0
    }

    var municipalityArea: String {
        return  String("\(home.municipality), \(home.area)")
    }

    var isImageDownloaded: Bool {
        return home.imageDownloaded
    }

    var imageData: Data? {
        return home.imageData
    }

    var imageUrl: String {
        return home.imageUrl
    }

    var image: UIImage {
        return home.image ?? UIImage(systemName: "house")!
    }
}
