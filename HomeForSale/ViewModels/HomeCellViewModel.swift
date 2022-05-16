//
//  HomeViewCellViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

class HomeCellViewModel: HomeCellViewModelType {
    
    private var home: Home
    
    var id: String {
        return home.id + " -> " + home.type
    }
    
    var area: String {
        return String(describing: home.area)
    }
    
    init(home: Home) {
        self.home = home
    }
}
