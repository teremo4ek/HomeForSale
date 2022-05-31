//
//  HomesViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 24.05.2022.
//

import Foundation

final class HomesViewModel {
    private var selectedIndexPath: IndexPath?
    private var dataManager: DataManager!

    weak var delegate: NetworkDataDelegate?

    private var homeList: [HomeCell] = []

    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.dataManager?.onCompletionHomeList = { [weak self] homeList in
            guard let self = self else { return }
            print("HomesViewModel onCompletionHomeList, homeList.count = \(homeList.count)")
            self.homeList = homeList
            self.delegate?.onComplition()
        }

        self.dataManager?.onCompletionImage = { [weak self] data, imageUrl in
            print("HomesViewModel onCompletionImage, url = \(imageUrl)")
            self?.updateHomeList(data: data, imageUrl: imageUrl)
        }
    }

    func numberOfRows() -> Int {
        return homeList.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> HomeInfoCellViewModel? {
        let homeCell = homeList[indexPath.row]
        if !homeCell.imageDownloaded {
            downloadImages(cell: homeCell)
        }
        return HomeInfoCellViewModel(home: homeCell)
    }

    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }

    func fetchData() {
        dataManager?.fetchData(forRequestType: .homeList)
    }

    // MARK: - Download Image by URL
    private func downloadImages(cell: HomeCell) {
        dataManager?.downloadImage(cell.imageUrl)
    }

    private func updateHomeList(data: Data?, imageUrl: String) {
        guard let data = data else { return }

        for cell in homeList {
            if cell.imageUrl == imageUrl {
                cell.imageData = data
                cell.imageDownloaded = true
            }
        }
    }
}
