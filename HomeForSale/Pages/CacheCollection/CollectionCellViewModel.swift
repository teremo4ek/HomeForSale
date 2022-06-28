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
    private let flickr = Flickr()

    weak var delegate: NetworkDataDelegate?

    init(_ photo: FlickrPhoto) {
        // print("+init CollectionCellViewModel id: \(photo.photoID)")
        flickrPhoto = photo
        getImage()
    }

    deinit {
        // print("-deinit CollectionCellViewModel id: \(flickrPhoto.photoID)")
    }

    var largeImage: UIImage?

    var photoID: String {
        return flickrPhoto.photoID
    }

    private func getImage() {

        if largeImage == nil {
            if flickrPhoto.state == .Downloaded {
                if !cachedImage() {
                    print("image broken and not loaded from cache \(flickrPhoto.photoID) ----")
                }
            } else if flickrPhoto.state == .NotDownloaded {
                downloadImageThrowInternet()
            }
        }
    }

    private func downloadImageThrowInternet() {
        DispatchQueue.global(qos: .utility).async { [weak self] in

            guard let flickrPhoto = self?.flickrPhoto else { return }

            self?.flickr.loadLargeImage(photo: flickrPhoto, completion: { result in
                do {
                    let image = try result.get()
                    print("Large image downloaded succesfuly: \(flickrPhoto.photoID)")
                    self?.largeImage = image
                    self?.delegate?.onImageDownloaded(id: flickrPhoto.photoID)

                    guard let data = image.pngData() else { return }
                    // guard let imageData = UIImage(data: data) else { return }
                    self?.cacheManager.storeImage(id: flickrPhoto.photoID, data: data as NSData)

                  } catch {
                      print("downloadImage error: \(error.localizedDescription)")
                  }
            })
        }
    }

    private func cachedImage() -> Bool {
        if let data = cacheManager.getImage(id: flickrPhoto.photoID) {

            if let image = UIImage(data: data) {
                print("image loaded from cache \(flickrPhoto.photoID) ++++++++++++++++")
                largeImage = image
                // delegate?.onImageDownloaded(id: flickrPhoto.photoID)
                return true
            } else {
                print("image loaded from cache, but data is broken \(flickrPhoto.photoID)")
                return true
            }
        }

        return false
    }

}
