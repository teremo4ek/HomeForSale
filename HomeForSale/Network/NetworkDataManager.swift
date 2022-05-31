//
//  NetworkDataManager.swift
//  HomeForSale
//
//  Created by Yury Bely on 31.05.2022.
//

import Foundation

final class NetworkDataManager: DataManagerProtocol {

    func fetchJson(_ path: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: path) {
            let session = URLSession(configuration: .default)
            let urlSessionTask = session.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    completion(.failure(error))
                }

                if let data = data {
                    completion(.success(data))
                }

                session.invalidateAndCancel()
            }
            urlSessionTask.resume()
        } else {
            completion(.failure(NetworkError.badURL))
        }
    }

    func fetchDataImage(_ path: String, completion: @escaping (Result<Data, Error>) -> Void) {

        if let url = URL(string: path) {
            print("Download Image Started url = \(url.absoluteString)")

            URLSession.shared.dataTask(with: url) { data, response, error in

                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")

                if let urlError = error as? URLError {
                  completion(.failure(urlError))
                }

                if let data = data {
                  completion(.success(data))
                }

              }.resume()
        } else {
            completion(.failure(NetworkError.badURL))
        }
    }

}
