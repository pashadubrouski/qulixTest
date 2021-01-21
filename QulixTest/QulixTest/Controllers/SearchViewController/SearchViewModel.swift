import UIKit

class SearchViewModel {
    
    var characters: Observer<[Character]> = Observer()
    
    private let router: SearchViewControllerRouter
    
    init(router: SearchViewControllerRouter) {
        self.router = router
    }
    
    var searchResult: Result?
    //  var selectedCharacter: Character?
    
    private var apiService: ApiService<Result> = ApiService()
    
    func openCharacterVC(index: Int) {
        guard let character = characters.data?[index] else { return }
        router.routeToCharacterViewController(characterId: character.id)
    }
    
    func stopSearch() {
        characters.data = nil
    }
    
    func searchCharacters(name: String) {
        let parameters = ["name": name]
        let path: Path = .characters(component: "", parameters: parameters)
        let httpTask = HTTPTask(path: path, method: .get, headers: nil)
        if name != "" {
            apiService.getData(httpTask: httpTask) { [weak self] (result, error) in
                DispatchQueue.main.async {
                    guard let result = result, result.results.count > 0, error == nil else {
                        self?.characters.data = []
                        switch error {
                        case .redirect: print("redirect")
                        case .requestError: print("requestError")
                        case .serverError: print("serverError")
                        case .none: print("Error")
                        }
                        return
                    }
                    self?.characters.data = result.results
                }
            }
        } else {
            characters.data = []
        }
    }
}
