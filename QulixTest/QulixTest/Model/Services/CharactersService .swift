import Foundation

//struct HTTPTask {
//    let baseUrl: RequestUrl
//    let endpoint: String
//    let method: String 
//}

protocol CharacterServiceProtocol {
    func getCharactersByName(with characterName: String, completion: @escaping (_ result: Result?, _ error: Error?) -> ())
    func getCharactersById(with characterId: Int, completion: @escaping (_ result: Character?, _ error: Error?) -> ()) 
}

enum RequestUrl: String {
    case byId = "https://rickandmortyapi.com/api/character/"
    case byName = "https://rickandmortyapi.com/api/character/?name="
}

protocol newCharacterSerivceProtocol {
    associatedtype DataType
    func getData(parameter: String, requestURL: RequestUrl, completion: @escaping (_ result: DataType?, _ error: Error?) -> () )
}

final class CharacterService2<T:Decodable>: newCharacterSerivceProtocol{
    typealias DataType = T
    func getData(parameter: String, requestURL: RequestUrl, completion: @escaping (T?, Error?) -> ()) {
        guard  let url = URL(string: "\(requestURL.rawValue)\(parameter)") else { return }
        print(url)
        let urlSession = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        urlSession.dataTask(with: request) { (data, _, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result, nil)
            } catch let error{
                print(error.localizedDescription)
                completion(nil, error)
            }
        }.resume()
        
    }
}

final class CharactersService: CharacterServiceProtocol {
   
    func getCharactersById(with characterId: Int, completion: @escaping (Character?, Error?) -> ()) {
        guard let url  = URL(string: "https://rickandmortyapi.com/api/character/\(characterId)") else { return }
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let character = try JSONDecoder().decode(Character.self, from: data)
                completion(character, nil)
            } catch let error{
                print(error.localizedDescription)
                completion(nil, error)
            }
        }.resume()
    }
    
    func getCharactersByName(with characterName: String, completion: @escaping (_ result: Result?, _ error: Error?) -> ()) {
        guard let url  = URL(string: "https://rickandmortyapi.com/api/character/?name=\(characterName)") else { return }
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                completion(result, nil)
            } catch let error{
                print(error.localizedDescription)
                completion(nil, error)
            }
        }.resume()
    }
}
