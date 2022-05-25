//
//  MainTableViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

class MainTableViewModel : MainTableViewModelType {
    
    private var selectedIndexPath: IndexPath?
    private weak var delegate: MainTableNetworkDataDelegate?
    private var networkDataManager: NetworkDataManager?
    
    var homeList: [HomeCell] = []
    
    init(delegate : MainTableNetworkDataDelegate, networkDataManager: NetworkDataManager) {
        self.delegate = delegate
        self.networkDataManager = networkDataManager
        self.networkDataManager?.onCompletionHomeList = { [weak self] homeList in
            guard let self = self else { return }
            print("MainTableViewModel onCompletionHomeList, homeList.count = \(homeList.count)")
            self.homeList = homeList
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
        return HomeDetailViewModel1(home: homeList[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func fetchData() {
        networkDataManager?.fetchData(forRequestType: .homeList)
    }
    
    // MARK: private func
    
    fileprivate func downladImages() {
        //for homeCell in homeList {
            //if let url = URL(string: homeCell.imageUrl) {
                //networkDataManager?.downloadImage(from: url, homeCell.id)
            //}
        //}
    }

}
