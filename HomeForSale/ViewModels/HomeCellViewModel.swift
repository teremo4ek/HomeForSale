//
//  HomeViewCellViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

class HomeCellViewModel: HomeCellViewModelType {
    
    private var home: HomeItm
    
    init(home: HomeItm) {
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
    
    var imageOfHouse: String{
        return home.image
    }
    
}
