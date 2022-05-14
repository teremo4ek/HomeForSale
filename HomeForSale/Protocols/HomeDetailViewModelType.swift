//
//  HomeDetailViewModelType.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

protocol HomeDetailViewModelType {
    var description: String { get }
    var age: Box<String?> { get }
}
