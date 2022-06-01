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

enum RequestType {
    case homeList
    case homeDetail

    var urlString: String {
        switch self {
        case .homeList:
            return Constants.UrlHomeList

        case .homeDetail:
            return Constants.UrlHomeDetail
        }
    }

    var filePath: String {
        switch self {
        case .homeList :
            return "HomesInfo"
        case .homeDetail:
            return "HomeDetail"
        }
    }
}

protocol DataManagerProtocol {
    func fetchJson(forType type: RequestType, completion: @escaping (Result<Data, Error>) -> Void)

    func fetchDataImage(_ path: String, completion: @escaping (Result<Data, Error>) -> Void)
}
