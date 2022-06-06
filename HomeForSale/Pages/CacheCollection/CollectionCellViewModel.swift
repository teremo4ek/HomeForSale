//
//  CollectionCellViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 02.06.2022.
//

import Foundation
import UIKit

class CollectionCellViewModel {
    private var flickrPhoto: FlickrPhoto!
    private let cacheManager = CacheManager.shared()

    weak var delegate: NetworkDataDelegate?

    init(_ photo: FlickrPhoto) {
        flickrPhoto = photo

        getImage()
    }

    var thumbnail: UIImage? {
        return flickrPhoto.thumbnail
    }

    var largeImage: UIImage? {
        return flickrPhoto.largeImage
    }

    var photoID: String {
        return flickrPhoto.photoID
    }

    private func getImage() {

        if !cachedImage() {
            downloadImageThrowInternet()
        }

    }

    private func downloadImageThrowInternet() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.flickrPhoto.loadLargeImage({ result in
                do {
                    let image = try result.get()
                    print("Large image downloaded succesfuly: \(image.photoID)")
                    self?.delegate?.onImageDownloaded(id: image.photoID)

                    guard let data = image.largeImage?.pngData() else { return }
                    // guard let imageData = UIImage(data: data) else { return }
                    self?.cacheManager.storeImage(id: image.photoID, data: data)

                  } catch {
                      print("downloadImage error: \(error.localizedDescription)")
                  }
            })
        }
    }

    private func cachedImage() -> Bool {
        if let data = cacheManager.getImage(id: flickrPhoto.photoID) {

            if let image = UIImage(data: data) {
                print("image loaded from cache ++++++++++++++++")
                flickrPhoto.largeImage = image
                // delegate?.onImageDownloaded(id: flickrPhoto.photoID)
                return true
            } else {
                print("image loaded from cache, but data is broken")
                flickrPhoto.largeImage = nil
                return true
            }
        }

        return false
    }

}
