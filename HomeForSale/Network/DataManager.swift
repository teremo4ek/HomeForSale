
import Foundation

//class for download json and images throw internet or localy
class DataManager {
    private var isTestMode: Bool = false
    
    var onCompletionHomeList: (([HomeCell]) -> Void)?
    var onCompletionHomeDetail: ((HomeDetail) -> Void)?
    var onCompletionImage: ((Data?, String) -> Void)?
    
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
    
    func fetchData(forRequestType requestType: RequestType) {
        var loadData: Data?
        if(isTestMode) {
            loadData = readLocalJson(forName: requestType.filePath)
        } else {
            // TODO
            print("Not Impliment yet!!!")
        }
        
        if let data = loadData {
            
            if requestType == .homeList {
                guard let myStruct = parse(model: HomeList.self, jsonData: data ) else { return }
                
                var homeCell = [HomeCell]()
                for homeItem in myStruct.items {
                    guard let cell = HomeCell(homeItem: homeItem) else { continue }
                    homeCell.append(cell)
                }
                
                self.onCompletionHomeList?(homeCell)
            }
            else if requestType == .homeDetail {
                guard let myStruct = parse(model: HomeDescription.self, jsonData: data ) else { return }
                
                guard let homeDetail = HomeDetail(homeDescription: myStruct) else { return }
                
                self.onCompletionHomeDetail?(homeDetail)
            }
            
            
        }
    }
    
    //MARK: - Private
    
    //read local json data
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
    
    //fetch json data from internet
    private func fetchJson(fromURLString urlString: String,
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
    
    
    //parse json data
    private func parse<T:Decodable>(model: T.Type, jsonData: Data) -> T? {
        do {
            let myStruct = try JSONDecoder().decode(T.self, from: jsonData)
            return myStruct
        } catch {
            return nil
        }
    }
    
    
    
}
