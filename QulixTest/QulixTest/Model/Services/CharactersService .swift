import Foundation

protocol CharacterServiceProtocol {
    func getCharactersByName(with characterName: String, completion: @escaping (_ result: Result?, _ error: Error?) -> ())
    func getCharactersById(with characterId: Int, completion: @escaping (_ result: Character?, _ error: Error?) -> ()) 
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
