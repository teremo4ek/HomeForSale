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
    private var searches: [FlickrSearchResults] = []
    private let flickr = Flickr()

    weak var delegate: NetworkDataDelegate?

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }

    deinit {
        print("Freeing up the HomeDetailViewModel")
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionCellViewModel? {

        let flicrPhoto = photo(for: indexPath)
        return CollectionCellViewModel(flicrPhoto)
    }

    func fetchData(text: String) {
        flickr.searchFlickr(for: text) { searchResults in
            DispatchQueue.main.async {

                switch searchResults {
                case .failure(let error) :
                    print("Error Searching: \(error)")
                case .success(let results):
                    print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                    self.searches.insert(results, at: 0)
                    self.delegate?.onComplition()

                }
            }
        }

    }

    func photo(for indexPath: IndexPath) -> FlickrPhoto {
        return searches[indexPath.section].searchResults[indexPath.row]
    }

    func numberOfSearchesPhrases() -> Int {
        return searches.count
    }

    func numberOfItemsInSection(section: Int) -> Int {
        return searches[section].searchResults.count
    }
}
