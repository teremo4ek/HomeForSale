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

    deinit {
        print("Freeing up the HomeDetailViewModel")
    }

    func fetchData() {
        dataManager?.fetchData(forRequestType: .homeDetail)
    }

    var imageUrl: String {
        return homeDetail?.imageUrl ?? ""
    }

    var streetAddress: String {
        return homeDetail?.streetAddress ?? ""
    }

    var municipalityArea: String {
        return String("\(homeDetail?.area), \(homeDetail?.municipality)")
    }

    var askingPrice: Int {
        return homeDetail?.askingPrice ?? 0
    }

    var homeDescription: String {
        return homeDetail?.homeDescription ?? ""
    }

    var livingArea: Int {
        return homeDetail?.livingArea ?? 0
    }

    var numberOfRooms: Int {
        return homeDetail?.numberOfRooms ?? 0
    }

    var patio: String {
        return homeDetail?.patio ?? "false"
    }

    var daysSincePublish: Int {
        return homeDetail?.daysSincePublish ?? 0
    }
}
