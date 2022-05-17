//
//  NetworkDataManager.swift
//  HomeForSale
//
//  Created by Yury Bely on 17.05.2022.
//

import Foundation

class NetworkDataManager {
    
    enum RequestType {
        case homeList
        case homeDetail(id: Int)
    }
    
    var onCompletionHomeList: ((HomeList) -> Void)?
    
    func fetchData(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .homeList:
            urlString = Constants.UrlHomeList
            
        case .homeDetail(_):
            urlString = Constants.UrlHomeDetail
        }
        
        performRequest(withURLString: urlString, requestType: requestType)
    }
    
    fileprivate func performRequest(withURLString urlString: String, requestType: RequestType) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let homeList = self.parseJSON(withData: data, withType: requestType) {
                    self.onCompletionHomeList?(homeList)
                }
            }
        }
        task.resume()
    }
    
    fileprivate func parseJSON(withData data: Data, withType type: RequestType) -> HomeList? {
        let decoder = JSONDecoder()
        
        print("parseJSON - \(type)")
        
        do {
            let homeList = try decoder.decode(HomeList.self, from: data)
            return homeList
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
