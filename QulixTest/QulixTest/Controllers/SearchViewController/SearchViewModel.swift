import UIKit

protocol Observer: class {
    func update(searchCharacters: [Character]?)
}

protocol Subject: class {
    var observers: [Observer] { get set }
    func notificateObservers()
}

class SearchViewModel: Subject {
    
    var observers: [Observer] = []
    
    private let router: SearchViewControllerRouter
    
    init(router: SearchViewControllerRouter) {
        self.router = router
    }
    
     var searchResult: Result?{
        didSet{
            notificateObservers()
        }
    }
//    var searchCharacters: [Character] = []
    var selectedCharacter: Character?
    private lazy var charactersService: CharacterServiceProtocol = {
        return CharactersService()
    }()
    
    func openCharacterVC(index: Int) {
        guard let chracter = searchResult?.results[index] else { return }
        router.routeToCharacterViewController(character: chracter)
    }
    
    func stopSearch() {
        searchResult = nil
    }
    
//    func searchUsers(urlString: String, coplition: @escaping (_ result: Bool) -> ()){
//        if urlString != ""{
//            charactersService.getCharacters(with: urlString) { (result, error) in
//                guard let result = result, result.results.count > 0, error == nil else {
//                    self.searchCharacters = []
//                    coplition(false)
//                    return
//                }
//                self.searchResult = result
//                self.searchCharacters = result.results
//                coplition(true)
//            }
//        } else {
//            searchCharacters.removeAll()
//            coplition(false)
//        }
//    }
    
    func searchUsers(urlString: String){
        if urlString != "" {
            charactersService.getCharacters(with: urlString) { [weak self] (result, error) in
                guard let result = result, result.results.count > 0, error == nil else {
                 //   self.searchCharacters = []
                    self?.searchResult = nil
                    return
                }
                self?.searchResult = result
              //  self.searchCharacters = result.results
            }
        } else {
         //   searchCharacters.removeAll()
            searchResult = nil
        }
        
        
    }
    
    func notificateObservers() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            for observer in self.observers{
                observer.update(searchCharacters: self.searchResult?.results)
            }
        }
        
    }
}

extension Subject {
    func register(observer: Observer){
        self.observers.append(observer)
    }
    
    func remove(observer: Observer){
        self.observers = self.observers.filter({$0 !== observer})
    }
}

