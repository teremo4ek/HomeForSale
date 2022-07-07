//
//  TapBarViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 06.07.2022.
//

import Foundation

class TapBarViewModel {

    let Items: [TabBarItem]

    init() {
        Items = [.hauseDetail, .cacheCollection]
    }

    enum TabBarItem: Int {
            case hauseDetail
            case cacheCollection

            var title: String {
                switch self {
                case .hauseDetail:
                    return "House Detail"
                case .cacheCollection:
                    return "Cache Collection"
                }
            }

            var iconName: String {
                switch self {
                case .hauseDetail:
                    return "house"
                case .cacheCollection:
                    return "person.crop.circle"
                }
            }
        }
}
