//
//  HomeDetailViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

class HomeDetailViewModel: HomeDetailViewModelType {
    
    private var home: Home
    
    var description: String {
        return String(describing: "\(home.id) \(home.area) !!!!")
    }
    
    var age: Box<String?> = Box(nil)
    
    init(home: Home) {
        self.home = home
    }
}
