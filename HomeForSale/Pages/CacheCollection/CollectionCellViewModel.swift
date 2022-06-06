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

    weak var delegate: NetworkDataDelegate?

    init(_ photo: FlickrPhoto) {
        flickrPhoto = photo

        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.flickrPhoto.loadLargeImage({ result in
                do {
                    let image = try result.get()
                    print("Large image downloaded succesfuly: \(image.photoID)")
                    self?.delegate?.onImageDownloaded(id: image.photoID)

                  } catch {
                      print("downloadImage error: \(error.localizedDescription)")
                  }
            })
        }
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

}
