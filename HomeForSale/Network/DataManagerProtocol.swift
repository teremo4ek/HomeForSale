//
//  DataManagerProtocol.swift
//  HomeForSale
//
//  Created by Yury Bely on 31.05.2022.
//

import Foundation

enum NetworkError: Error {
    case badURL
}

protocol DataManagerProtocol {
    func fetchJson(_ path: String, completion: @escaping (Result<Data, Error>) -> Void)

    func fetchDataImage(_ path: String, completion: @escaping (Result<Data, Error>) -> Void)
}
