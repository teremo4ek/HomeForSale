//
//  MainTableViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

class MainTableViewModel : MainTableViewModelType {
    
    private var selectedIndexPath: IndexPath?
    private var delegate: MainTableNetworkDataDelegate?
    private var networkDataManager: NetworkDataManager?
    
    var homeList = [
        HomeItm(type: "firstType", id: "id0", askingPrice: nil, municipality: nil, area: "area0", daysSincePublish: nil, livingArea: nil, numberOfRooms: nil, streetAddress: nil, image: "", monthlyFee: nil, ratingFormatted: nil, averagePrice: nil),
        HomeItm(type: "secondType", id: "id1", askingPrice: nil, municipality: nil, area: "area1", daysSincePublish: nil, livingArea: nil, numberOfRooms: nil, streetAddress: nil, image: "", monthlyFee: nil, ratingFormatted: nil, averagePrice: nil),
        HomeItm(type: "thirdType", id: "id2", askingPrice: nil, municipality: nil, area: "area2", daysSincePublish: nil, livingArea: nil, numberOfRooms: nil, streetAddress: nil, image: "", monthlyFee: nil, ratingFormatted: nil, averagePrice: nil)
    ]
    
    init(delegate : MainTableNetworkDataDelegate, networkDataManager: NetworkDataManager) {
        self.delegate = delegate
        self.networkDataManager = networkDataManager
        self.networkDataManager?.onCompletionHomeList = { [weak self] homeList in
            guard let self = self else { return }
            print("MainTableViewModel onCompletionHomeList, homeList.count = \(homeList.items.count)")
            self.homeList = homeList.items
            self.delegate?.onComplition()
        }
    }
    
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
    
    func fetchData() {
        networkDataManager?.fetchData(forRequestType: .homeList)
    }

}
