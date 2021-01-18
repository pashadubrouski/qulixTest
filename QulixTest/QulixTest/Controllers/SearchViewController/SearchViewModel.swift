import UIKit

class SearchViewModel {
    
    var characters: Observer<[Character]> = Observer()
    
    private let router: SearchViewControllerRouter
    
    init(router: SearchViewControllerRouter) {
        self.router = router
    }
    
    var searchResult: Result?
    var selectedCharacter: Character?
    private lazy var charactersService: CharacterServiceProtocol = {
        return CharactersService()
    }()
    
    func openCharacterVC(index: Int) {
        guard let chracter = characters.data?[index] else { return }
        router.routeToCharacterViewController(character: chracter)
    }
    
    func stopSearch() {
        characters.data = nil
    }

    func searchUsers(urlString: String){
        if urlString != "" {
            charactersService.getCharacters(with: urlString) { [weak self] (result, error) in
                DispatchQueue.main.async {
                    guard let result = result, result.results.count > 0, error == nil else {
                        self?.characters.data = nil
                        return
                    }
                    self?.characters.data = result.results
                }
            }
        } else {
            characters.data = nil
        }
    }
}
