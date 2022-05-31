//
//  LocalDataManager.swift
//  HomeForSale
//
//  Created by Yury Bely on 31.05.2022.
//

import Foundation

final class LocalDataManager: DataManagerProtocol {
    func fetchJson(_ path: String, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            if let bundlePath = Bundle.main.path(forResource: path,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                completion(.success(jsonData))
            }
        } catch {
            print(error.localizedDescription)
            completion(.failure(error))
        }
    }

    func fetchDataImage(_ path: String, completion: @escaping (Result<Data, Error>) -> Void) {

    }

}
