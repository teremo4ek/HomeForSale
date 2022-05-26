//
//  HomeDetailViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 25.05.2022.
//

import Foundation

final class HomeDetailViewModel {
    private var dataManager: DataManager!
    
    weak var delegate: NetworkDataDelegate?
    
    var homeDetail: HomeDetail?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.dataManager?.onCompletionHomeDetail = { [weak self] homeDetail in
            guard let self = self else { return }
            print("HomeDetailViewModel onCompletionHomeDetail, homeDetail.id = \(homeDetail.id)")
            self.homeDetail = homeDetail
            self.delegate?.onComplition()
        }
    }
    
    func fetchData() {
        dataManager?.fetchData(forRequestType: .homeDetail)
    }
}
