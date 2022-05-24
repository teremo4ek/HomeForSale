//
//  HomesViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 24.05.2022.
//

import Foundation

final class HomesViewModel {
    private var selectedIndexPath: IndexPath?
    private var dataManager: NetworkDataManager!
    
    weak var delegate: NetworkDataDelegate?
    
    private var homeList: [HomeCell] = []
    
    init(dataManager: NetworkDataManager) {
        self.dataManager = dataManager
        self.dataManager?.onCompletionHomeList = { [weak self] homeList in
            guard let self = self else { return }
            print("HomesViewModel onCompletionHomeList, homeList.count = \(homeList.count)")
            self.homeList = homeList
            self.delegate?.onComplition()
        }
    }

    func numberOfRows() -> Int {
        return homeList.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> HomeInfoCellViewModel? {
        let home = homeList[indexPath.row]
        return HomeInfoCellViewModel(home: home)
    }
    
    func viewModelForSelectedRow() -> HomeDetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return HomeDetailViewModel(home: homeList[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func fetchData() {
        dataManager?.fetchData(forRequestType: .homeList)
    }
}
