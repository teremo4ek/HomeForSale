import Foundation
import UIKit

// class for download json and images throw internet or localy
class DataManager {
    private let manager: DataManagerProtocol

    var onCompletionHomeList: (([HomeCell]) -> Void)?
    var onCompletionHomeDetail: ((HomeDetail) -> Void)?
    var onCompletionImage: ((Data?, String) -> Void)?

    private static var sharedDataManager: DataManager = {
        let dataManager = DataManager(NetworkDataManager())
            return dataManager
        }()

    private init(_ dataManager: DataManagerProtocol) {
        manager = dataManager
    }

    // MARK: - Accessors
    class func shared() -> DataManager {
        return sharedDataManager
    }

    func fetchData(forRequestType requestType: RequestType) {

        manager.fetchJson(forType: requestType) { [weak self] result in
            do {
                let loadData  = try result.get()
                self?.analizaData(loadData: loadData, type: requestType)
            } catch {
                print("fetchData error: \(error.localizedDescription)")
            }
        }
    }

    func downloadImage(_ imageUrl: String) {
        manager.fetchDataImage(imageUrl) { [weak self] result in
            do {
                let imageData = try result.get()
                self?.onCompletionImage?(imageData, imageUrl)

              } catch {
                  print("downloadImage error: \(error.localizedDescription)")
              }
        }
    }

    // MARK: - Private

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
}
