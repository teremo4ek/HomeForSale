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
        
        var urlString: String {
            switch self {
            case .homeList:
                return Constants.UrlHomeList
                
            case .homeDetail(_):
                return Constants.UrlHomeDetail
            }
        }
    }
    
    var onCompletionHomeList: (([HomeCell]) -> Void)?
    var onCompletionImage: ((Data?, String) -> Void)?
    
    // TODO 
    // MARK - Fetch Data API
    func fetchData(forRequestType requestType: RequestType) {
        performRequest(withURLString: requestType.urlString, requestType: requestType)
    }
    
    fileprivate func performRequest(withURLString urlString: String, requestType: RequestType) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let homeList = self.parseJSON(withData: data, withType: requestType) {
                    var homeCell = [HomeCell]()
                    for homeItem in homeList.items {
                        guard let cell = HomeCell(homeItem: homeItem) else { continue }
                        homeCell.append(cell)
                    }
                    
                    self.onCompletionHomeList?(homeCell)
                }
            }
        }
        task.resume()
    }
    
    fileprivate func parseJSON(withData data: Data, withType type: RequestType) -> HomeList? {
        let decoder = JSONDecoder()
        
        print("parseJSON - \(type)")
        
        //if let JSONString = String(data: data, encoding: String.Encoding.utf8)
        //{
        //    print(JSONString)
        //}
        
        do {
            let homeList = try decoder.decode(HomeList.self, from: data)
            return homeList
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    // MARK Fetch Image data
    fileprivate func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, id: String) {
        print("Download Img Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil
            else {
                print("Download Img  Failed")
                //self.onCompletionImage?(nil)
                return
            }

            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Img Finished Successfuly")
            
            self.onCompletionImage?(data, id)
        }
    }
    
}
