//
//  NetworkDataManager.swift
//  HomeForSale
//
//  Created by Yury Bely on 17.05.2022.
//

import Foundation

class NetworkDataManager {
    
    var isTestMode: Bool
    
    init(testMode: Bool = false) {
        self.isTestMode = testMode
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

    var onCompletionHomeList: (([HomeCell]) -> Void)?
    var onCompletionHomeDetail: ((HomeDetail) -> Void)?
    var onCompletionImage: ((Data?, String) -> Void)?
    
    // TODO 
    // MARK - Fetch Data API
    func fetchData(forRequestType requestType: RequestType) {
        var data: Data?
        if(isTestMode) {
            data = readLocalFile(forName: requestType.filePath)
        } else {
            // TODO
            print("Not Impliment yet!!!")
        }
        
        if data != nil {
            
            do {
                if requestType == .homeList {
                    let homeList = try JSONDecoder().decode(HomeList.self, from: data!)
                    var homeCell = [HomeCell]()
                    for homeItem in homeList.items {
                        guard let cell = HomeCell(homeItem: homeItem) else { continue }
                        homeCell.append(cell)
                    }
                        
                    self.onCompletionHomeList?(homeCell)
                }
                else if requestType == .homeDetail {
                    let homeDescription = try JSONDecoder().decode(HomeDescription.self, from: data!)
                    guard let homeDetail = HomeDetail(homeDescription: homeDescription) else { return }
    
                    self.onCompletionHomeDetail?(homeDetail)
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
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
    
    
    
    
    
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }

    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(HomeList.self,
                                                       from: jsonData)
        } catch {
            print("decode error")
        }
    }
    
}
