//
//  HomeDetailViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

class HomeDetailViewModel: HomeDetailViewModelType {
    //TODO 
    private var homeDescription = HomeDescription(
        type: "HighlightedProperty",
        id: "id1",
        askingPrice: 54000,
        municipality: "Gällivare kommun",
        area: "Heden",
        daysSincePublish: 3,
        livingArea: 86,
        numberOfRooms: 5,
        streetAddress: "Mockvägen 1",
        image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg",
        homeDescription: "The living room can be furnished according to your own wishes and tastes, here the whole family can gather and enjoy each other's company. From the living room you reach the terrace overlooking the lush courtyard which is located in undisturbed and secluded location.",
        patio: "Yes")
    
    private var home: Home
    
    init(home: Home) {
        self.home = home
    }
    
    var type: TypeCell{
        return .Property
    }
    
    var id: String {
        return homeDescription.id
    }
    
    var askingPrice: Int {
        return homeDescription.askingPrice
    }
    
    var municipalityArea: String {
        return String("\(homeDescription.area), \(homeDescription.municipality)")
    }
    
    var daysSincePublish: Int {
        return homeDescription.daysSincePublish
    }
    
    var livingArea: Int {
        return homeDescription.livingArea
    }
    
    var numberOfRooms: Int {
        return homeDescription.numberOfRooms
    }
    
    var streetAddress: String {
        return homeDescription.streetAddress
    }
    
    var image: String {
        return homeDescription.image
    }
    
    var description: String {
        return homeDescription.homeDescription
    }
    
    var patio: String {
        return homeDescription.patio
    }
    
    
}
