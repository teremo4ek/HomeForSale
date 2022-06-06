//
//  CacheManager.swift
//  HomeForSale
//
//  Created by Yury Bely on 06.06.2022.
//

import Foundation

class CacheManager {

    let cache = NSCache<NSString, NSData>()

    private static var sharedCacheManager: CacheManager = {
        let manager = CacheManager()
            return manager
        }()

    private init() {
        print("init CacheManager")
    }

    deinit {
        print("deinit CacheManager")
    }

    // MARK: - Accessors
    class func shared() -> CacheManager {
        return sharedCacheManager
    }

    func storeImage(id: String, data: Data) {

        let dataNS = NSData(data: data)
        let idNS = NSString(string: id)
        cache.setObject(dataNS, forKey: idNS)

        print("CacheManager.storeImage  id \(id)")
    }

    func getImage(id: String) -> Data? {

        let idNS = NSString(string: id)
        if let cachedData = cache.object(forKey: idNS) {
            // print("CacheManager.getImage  id \(id)")
            let data = Data(referencing: cachedData)
            return data
        }

        return nil
    }

}
