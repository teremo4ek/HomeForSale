//
//  NetworkDataDelegate.swift
//  HomeForSale
//
//  Created by Yury Bely on 25.05.2022.
//

import Foundation

protocol NetworkDataDelegate: AnyObject {
    func onComplition()
    func onHomeInfoCellUpdated(indexes: [Int])
    func onImageDownloaded(id: String)
}
