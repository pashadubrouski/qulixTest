import Foundation

protocol ApiServiceProtocol {
    associatedtype DataType
    func getData(httpTask: HTTPTask, completion: @escaping (_ result: DataType?, _ error: NetworkError?) -> ())
    func cancel()
}

struct HTTPTask {
    let domain = "https://rickandmortyapi.com/api/"
    var path: Path
    var method: HttpMethod
    var headers: [String:Any]?
}

enum Path {
    case characters(idComponent: String, nameParameters: [String: String])
    var rawValue: String {
        switch self {
        case .characters(let idComponent, let nameParameters):
            var parameters = ""
            if idComponent == "" {
                parameters = "?" + "\(nameParameters.map({$0.key + "=" + $0.value}).joined(separator: "&"))"
            }
            return "character/\(idComponent)" + parameters
        }
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    init (withStatusCode code: Int) {
        switch code%100 {
        case 3: self = .redirect
        case 4: self = .requestError
        case 5: self = .serverError
        default: self = .requestError
        }
    }

    case redirect, requestError, serverError
}

class ApiService<T:Decodable>: ApiServiceProtocol {
    private var task: URLSessionTask?
    typealias DataType = T
    
    func getData(httpTask: HTTPTask, completion: @escaping (T?, NetworkError?) -> ()) {
        print("\(httpTask.domain)\(httpTask.path.rawValue)")
        guard  let url = URL(string: "\(httpTask.domain)\(httpTask.path.rawValue)") else { return }
        let urlSession = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = httpTask.method.rawValue
        task = urlSession.dataTask(with: request) { (data, responce, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result, nil)
            } catch  {
                guard  let responce = responce as? HTTPURLResponse else {
                    return
                }
                if (responce.statusCode != 200) {
                    completion(nil, .init(withStatusCode: responce.statusCode))
                }
            }
        }
        task?.resume()
    }
    
    func cancel() { task?.cancel() }
}
