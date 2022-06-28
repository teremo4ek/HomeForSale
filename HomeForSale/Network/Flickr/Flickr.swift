import UIKit

let apiKey = "17bf8751172b091ad0eb9c453a3f2be1"

class Flickr {
    enum Error: Swift.Error {
        case unknownAPIResponse
        case generic

        case invalidURL
        case noData
    }

    func searchFlickr(for searchTerm: String, completion: @escaping (Result<FlickrSearchResults, Swift.Error>) -> Void) {
        guard let searchURL = flickrSearchURL(for: searchTerm) else {
            completion(.failure(Error.unknownAPIResponse))
            return
        }

        URLSession.shared.dataTask(with: URLRequest(url: searchURL)) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard
                (response as? HTTPURLResponse) != nil,
                let data = data
            else {
                completion(.failure(Error.unknownAPIResponse))
                return
            }

            do {
                guard
                    let resultsDictionary = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject],
                    let stat = resultsDictionary["stat"] as? String
                else {
                    completion(.failure(Error.unknownAPIResponse))
                    return
                }

                switch stat {
                case "ok":
                    print("Results processed OK")
                case "fail":
                    completion(.failure(Error.generic))
                    return
                default:
                    completion(.failure(Error.unknownAPIResponse))
                    return
                }

                guard
                    let photosContainer = resultsDictionary["photos"] as? [String: AnyObject],
                    let photosReceived = photosContainer["photo"] as? [[String: AnyObject]]
                else {
                    completion(.failure(Error.unknownAPIResponse))
                    return
                }

                let flickrPhotos = self.getPhotos(photoData: photosReceived)
                let searchResults = FlickrSearchResults(searchTerm: searchTerm, searchResults: flickrPhotos)
                completion(.success(searchResults))
            } catch {
                completion(.failure(error))
                return
            }
        }
        .resume()
    }

    private func getPhotos(photoData: [[String: AnyObject]]) -> [FlickrPhoto] {
        let photos: [FlickrPhoto] = photoData.compactMap { photoObject in
            guard
                let photoID = photoObject["id"] as? String,
                let farm = photoObject["farm"] as? Int ,
                let server = photoObject["server"] as? String ,
                let secret = photoObject["secret"] as? String
            else {
                return nil
            }

            let flickrPhoto = FlickrPhoto(photoID: photoID, farm: farm, server: server, secret: secret)
            return flickrPhoto
            //            guard
            //                let url = flickrPhoto.flickrImageURL(),
            //                let imageData = try? Data(contentsOf: url as URL)
            //            else {
            //                return nil
            //            }
            //
            //            if let image = UIImage(data: imageData) {
            //                flickrPhoto.thumbnail = image
            //                return flickrPhoto
            //            } else {
            //                return nil
            //            }
        }
        return photos
    }

    private func flickrSearchURL(for searchTerm: String) -> URL? {
        guard let escapedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
            return nil
        }

        let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(escapedTerm)&per_page=40&format=json&nojsoncallback=1"
        return URL(string: URLString)
    }

    // MARK: - download images

    private func flickrImageURL(photo: FlickrPhoto, size: String = "m") -> URL? {
        return URL(string: "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.photoID)_\(photo.secret)_\(size).jpg")
    }

    func loadLargeImage(photo: FlickrPhoto, completion: @escaping (Result<UIImage, Swift.Error>) -> Void) {
        guard let loadURL = flickrImageURL(photo: photo, size: "b") else {
            completion(.failure(Error.invalidURL))
            return
        }

        let loadRequest = URLRequest(url: loadURL)

        URLSession.shared.dataTask(with: loadRequest) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(Error.noData))
                return
            }

            if let returnedImage = UIImage(data: data) {
                completion(.success(returnedImage))
            } else {
                completion(.failure(Error.noData))
            }
        }
        .resume()
    }

    func loadCGImageSource(photo: FlickrPhoto, completion: @escaping (Result<CGImageSource, Swift.Error>) -> Void) {
        guard let loadURL = flickrImageURL(photo: photo, size: "b") else {
            completion(.failure(Error.invalidURL))
            return
        }

        let loadRequest = URLRequest(url: loadURL)

        URLSession.shared.dataTask(with: loadRequest) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(Error.noData))
                return
            }

            let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
            if let returnedImage = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) {
                completion(.success(returnedImage))
            } else {
                completion(.failure(Error.noData))
            }
        }
        .resume()
    }
}
