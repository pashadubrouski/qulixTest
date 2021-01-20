import Foundation
import UIKit

class CharacterViewModel {
    
    //MARK:- Properties
    
    var character: Observer<Character> = Observer()
    var characterId: Int
    
    private lazy var charactersService: CharacterServiceProtocol = {
        return CharactersService()
    }()
    
    var searchService: CharacterService2<Character> = CharacterService2()
    
    var apiService: ApiService<Character> = ApiService()
    
    private let router: CharacterViewControllerRouter
    init(router: CharacterViewControllerRouter, characterId: Int) {
        self.router = router
        self.characterId = characterId
    }
    
    //MARK: - Methods 
    func openSearchViewController() {
        router.routeToSearchViewController()
    }
    
    func getInfoAboutCharacter() {
        let idComponent = String(characterId)
        let path: Path = .characters(idComponent: idComponent, nameParameters: ["":""])
        let httpTask = HTTPTask(path: path, method: .get, headers: nil)
        apiService.getData(httpTask: httpTask) { [weak self] (result, error) in
            DispatchQueue.main.async {
                guard let result = result , error == nil else {
                    self?.character.data = nil
                    return
                }
                self?.character.data = result
            }
        }
    }
    
    func getInfoAboutCharacter2() {
        searchService.getData(parameter: String(characterId), requestURL: .byId) { [weak self] (result, error) in
            DispatchQueue.main.async {
                guard let result = result , error == nil else {
                    self?.character.data = nil
                    return
                }
                self?.character.data = result
            }
        }
    }
}
