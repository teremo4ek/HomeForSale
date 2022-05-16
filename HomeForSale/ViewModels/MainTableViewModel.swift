//
//  MainTableViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

class MainTableViewModel : MainTableViewModelType {
    private var selectedIndexPath: IndexPath?
    
    
    var homeList = [
        Home(type: "firstType", id: "id0", askingPrice: nil, municipality: nil, area: "area0", daysSincePublish: nil, livingArea: nil, numberOfRooms: nil, streetAddress: nil, image: "", monthlyFee: nil, ratingFormatted: nil, averagePrice: nil),
        Home(type: "secondType", id: "id1", askingPrice: nil, municipality: nil, area: "area1", daysSincePublish: nil, livingArea: nil, numberOfRooms: nil, streetAddress: nil, image: "", monthlyFee: nil, ratingFormatted: nil, averagePrice: nil),
        Home(type: "thirdType", id: "id2", askingPrice: nil, municipality: nil, area: "area2", daysSincePublish: nil, livingArea: nil, numberOfRooms: nil, streetAddress: nil, image: "", monthlyFee: nil, ratingFormatted: nil, averagePrice: nil)
    ]
    
    func numberOfRows() -> Int {
        return homeList.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> HomeCellViewModelType? {
        let home = homeList[indexPath.row]
        return HomeCellViewModel(home: home)
    }
    
    func viewModelForSelectedRow() -> HomeDetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return HomeDetailViewModel(home: homeList[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
