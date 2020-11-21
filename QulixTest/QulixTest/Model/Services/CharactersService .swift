import Foundation

protocol CharacterServiceProtocol {
    func getCharacters(with characterName: String, completion: @escaping (_ result: Result?, _ error: Error?) -> ())
}

final class CharactersService: CharacterServiceProtocol {
    func getCharacters(with characterName: String, completion: @escaping (_ result: Result?, _ error: Error?) -> ()) {
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
