import Foundation
import UIKit

class CharacterViewModel {
    
    //MARK:- Properties
    
    var character: Observer<Character> = Observer()
    var characterId: Int
    
    private lazy var charactersService: CharacterServiceProtocol = {
        return CharactersService()
    }()
    
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
        charactersService.getCharactersById(with: characterId) {[weak self] (result, error) in
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
