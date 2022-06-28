//
//  CacheCollectionViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 02.06.2022.
//

import Foundation
import UIKit

class CacheCollectionViewModel {
    private var selectedIndexPath: IndexPath?
    private var dataManager: DataManager!
    private var searches: [FlickrSearchResults] = []
    private let flickr = Flickr()
    private let cacheManager = CacheManager.shared()
    let flickrQueue = DispatchQueue(label: "Flickr queue")

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

    func downloadImage(paths indexPaths: [IndexPath]) {

        for indexPath in indexPaths {
            let flickrPhoto = photo(for: indexPath)
            if flickrPhoto.state == .NotDownloaded {
                flickrPhoto.state = .Processing
                flickrQueue.async { [weak self, indexPath]  in
                    self?.flickr.loadLargeImage(photo: flickrPhoto, completion: { result in
                        do {
                            let image = try result.get()
                            print("Large image downloaded succesfuly: \(flickrPhoto.photoID)")

                            guard let data = image.pngData() else { return }
                            self?.cacheManager.storeImage(id: flickrPhoto.photoID, data: data as NSData)
                            flickrPhoto.state = .Downloaded

                            self?.delegate?.onImageDownloaded(id: flickrPhoto.photoID)
                            self?.delegate?.onHomeInfoCellUpdated(indexPaths: [indexPath])

                          } catch {
                              flickrPhoto.state = .NotDownloaded
                              print("downloadImage error: \(error.localizedDescription)")
                          }
                    })
                }
            }
        }

    }
}
