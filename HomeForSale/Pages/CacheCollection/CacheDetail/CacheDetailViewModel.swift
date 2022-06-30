//
//  CacheDetailViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 29.06.2022.
//

import Foundation
import UIKit

class CacheDetailViewModel {
    private var flickrPhoto: FlickrPhoto!
    private let cacheManager = CacheManager.shared()

    weak var delegate: NetworkDataDelegate?

    init(_ photo: FlickrPhoto) {
        print("+init CacheDetailViewModel id: \(photo.photoID)")
        flickrPhoto = photo

        likeImage = flickrPhoto.like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }

    deinit {
        print("-deinit CacheDetailViewModel id: \(flickrPhoto.photoID)")
    }

    var largeImage: UIImage?

    var likeImage: UIImage!

    var photoID: String {
        return flickrPhoto.photoID
    }

    func getImage() {

        if largeImage == nil {
            if flickrPhoto.state == .Downloaded {
                cachedImage()
            } else {
                print("Image not downloaded id= \(flickrPhoto.photoID)")
            }
        }
    }

    func likeAction() {
        print("likeAction id=\(flickrPhoto.photoID)")
        flickrPhoto.like = !flickrPhoto.like

        likeImage = flickrPhoto.like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")

        delegate?.onImageDownloaded(id: flickrPhoto.photoID)
    }

    // MARK: - - Private

    private func cachedImage() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let photoID = self?.flickrPhoto.photoID else { return }

            if let data = self?.cacheManager.getImage(id: photoID) {
                if let image = UIImage(data: data) {
                    print("image loaded from cache \(photoID) ++++++++++++++++")
                    self?.largeImage = image
                    self?.delegate?.onImageDownloaded(id: photoID)
                }
            }
        }
    }
}
