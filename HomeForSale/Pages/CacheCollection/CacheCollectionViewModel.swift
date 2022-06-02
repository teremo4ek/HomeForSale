//
//  CacheCollectionViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 02.06.2022.
//

import Foundation

class CacheCollectionViewModel {
    private var selectedIndexPath: IndexPath?
    private var dataManager: DataManager!

    weak var delegate: NetworkDataDelegate?

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }

    deinit {
        print("Freeing up the HomeDetailViewModel")
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionCellViewModel? {

        return CollectionCellViewModel()
    }

    func fetchData() {
        // dataManager?.fetchData(forRequestType: .homeDetail)
    }

}
