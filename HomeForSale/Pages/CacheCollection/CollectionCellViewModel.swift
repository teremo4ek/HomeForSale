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

    var imageViewScale: CGFloat = 1.0
    var imageViewSize: CGSize = .zero

    weak var delegate: NetworkDataDelegate?

    init(_ photo: FlickrPhoto) {
        // print("+init CollectionCellViewModel id: \(photo.photoID)")
        flickrPhoto = photo

        likeImage = flickrPhoto.like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }

    deinit {
        // print("-deinit CollectionCellViewModel id: \(flickrPhoto.photoID)")
    }

    var largeImage: UIImage?

    var likeImage: UIImage!

    var photoID: String {
        return flickrPhoto.photoID
    }

    func loadImage() {
        getImage()
    }

    func likeAction() {
        print("likeAction id=\(flickrPhoto.photoID)")
        flickrPhoto.like = !flickrPhoto.like

        likeImage = flickrPhoto.like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")

        delegate?.onImageDownloaded(id: flickrPhoto.photoID)
    }

    private func getImage() {

        if largeImage == nil {
            if flickrPhoto.state == .Downloaded {
                cachedImage()
            } else if flickrPhoto.state == .NotDownloaded {
                downloadImageThrowInternet()
            }
        }
    }

    private func downloadImageThrowInternet() {
        DispatchQueue.global(qos: .utility).async { [weak self] in

            guard let flickrPhoto = self?.flickrPhoto else { return }
            flickrPhoto.state = .Processing

            self?.flickr.loadCGImageSource(photo: flickrPhoto, completion: { result in
                do {
                    let imageSource = try result.get()
                    print("Large image downloaded succesfuly: \(flickrPhoto.photoID)")

                    guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) else { return }
                    let image = UIImage(cgImage: cgImage)
                    guard let data = image.pngData() else { return }
                    self?.cacheManager.storeImage(id: flickrPhoto.photoID, data: data as NSData)
                    flickrPhoto.state = .Downloaded

                    if self?.imageViewSize == .zero {
                        self?.largeImage = image
                    } else {
                        guard let size = self?.imageViewSize else { return }
                        guard let scale = self?.imageViewScale else { return }
                        self?.largeImage =  downsampleCGImageSource(imageSource, to: size, scale: scale)
                    }
                    self?.delegate?.onImageDownloaded(id: flickrPhoto.photoID)

                  } catch {
                      flickrPhoto.state = .NotDownloaded
                      print("downloadImage error: \(error.localizedDescription)")
                  }
            })
        }
    }

    private func cachedImage() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let photoID = self?.flickrPhoto.photoID else { return }
            guard let size = self?.imageViewSize else { return }
            guard let scale = self?.imageViewScale else { return }

            if let data = self?.cacheManager.getImage(id: photoID) {
                if let imageSource = CGImageSourceCreateWithData(data as NSData, nil) {
                    self?.largeImage =  downsampleCGImageSource(imageSource, to: size, scale: scale)
                    print("image loaded from cache \(photoID) ++++++++++++++++")

                    self?.delegate?.onImageDownloaded(id: photoID)
                }
            }

            if self?.largeImage == nil {
                print("image broken and not loaded from cache \(photoID) ----")
                self?.flickrPhoto.state = .NotDownloaded
            }

        }
    }

}
