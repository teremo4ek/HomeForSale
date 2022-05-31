import Foundation
import UIKit

// class for download json and images throw internet or localy
class DataManager {
    private var isTestMode: Bool = false

    var onCompletionHomeList: (([HomeCell]) -> Void)?
    var onCompletionHomeDetail: ((HomeDetail) -> Void)?
    var onCompletionImage: ((Data?, String) -> Void)?

    private static var sharedDataManager: DataManager = {
        let dataManager = DataManager(testMode: false)
            return dataManager
        }()

    private init(testMode: Bool = false) {
        self.isTestMode = testMode
    }

    // MARK: - Accessors
    class func shared() -> DataManager {
        return sharedDataManager
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

    func fetchData(forRequestType requestType: RequestType) {
        if isTestMode {
            let loadData = readLocalJson(forName: requestType.filePath)
            analizaData(loadData: loadData, type: requestType)
        } else {
            fetchJson(fromURLString: requestType.urlString, completion: { [weak self] (result) in
                do {
                    let loadData  = try result.get()
                    self?.analizaData(loadData: loadData, type: requestType)
                } catch {
                    print(error.localizedDescription)
                }
            })
        }
    }

    // MARK: - Private

    // read local json data
    private func readLocalJson(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    // fetch json data from internet
    private func fetchJson(fromURLString urlString: String,
                           completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
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
        }
    }

    // parse json data
    private func parse<T: Decodable>(model: T.Type, jsonData: Data) -> T? {
        do {
            let myStruct = try JSONDecoder().decode(T.self, from: jsonData)
            return myStruct
        } catch {
            return nil
        }
    }

    private func analizaData(loadData: Data?, type: RequestType) {
        guard let data = loadData else { return }

        if type == .homeList {
            guard let myStruct = parse(model: HomeList.self, jsonData: data ) else { return }

            var homeCell = [HomeCell]()
            for homeItem in myStruct.items {
                guard let cell = HomeCell(homeItem: homeItem) else { continue }
                homeCell.append(cell)
            }

            self.onCompletionHomeList?(homeCell)
        } else if type == .homeDetail {
            guard let myStruct = parse(model: HomeDescription.self, jsonData: data ) else { return }

            guard let homeDetail = HomeDetail(homeDescription: myStruct) else { return }

            self.onCompletionHomeDetail?(homeDetail)
        }
    }

    // MARK: - Download Images

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(_ imageUrl: String) {

        guard let url = URL(string: imageUrl) else { return }

        print("Download Image Started url = \(url.absoluteString)")
        getData(from: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }

            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            self?.onCompletionImage?(data, imageUrl)
        }
    }

}
