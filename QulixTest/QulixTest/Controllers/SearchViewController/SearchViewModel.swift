import UIKit

class SearchViewModel {
    
    private let router: SearchViewControllerRouter
    
    init(router: SearchViewControllerRouter) {
        self.router = router
    }
    
    private var searchResult: Result?
    var searchCharacters: [Character] = []
    var selectedCharacter: Character?
    private lazy var charactersService: CharacterServiceProtocol = {
        return CharactersService()
    }()
    
    func openCharacterVC(index: Int) {
        let character = searchCharacters[index]

        router.routeToCharacterViewController(character: character)
    }
    
    func searchUsers(urlString: String, coplition: @escaping (_ result: Bool) -> ()){
        if urlString != ""{
        charactersService.getCharacters(with: urlString) { (result, error) in
            guard let result = result, result.results.count > 0, error == nil else {
                self.searchCharacters = []
                coplition(false)
                return
            }
            self.searchResult = result
            self.searchCharacters = result.results
            coplition(true)
        }
        } else {
                searchCharacters.removeAll()
            coplition(false)
        }
    }
}
