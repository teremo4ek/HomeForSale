import UIKit

enum FlickrPhotoState {
    case NotDownloaded
    case Processing
    case Downloaded
}

class FlickrPhoto: Equatable {
    let photoID: String
    let farm: Int
    let server: String
    let secret: String

    var state: FlickrPhotoState = .NotDownloaded
    var like: Bool = false

    init (photoID: String, farm: Int, server: String, secret: String) {
        self.photoID = photoID
        self.farm = farm
        self.server = server
        self.secret = secret
    }

    static func == (lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
        return lhs.photoID == rhs.photoID
    }
}
