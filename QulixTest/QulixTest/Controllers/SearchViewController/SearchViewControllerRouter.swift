import UIKit

class SearchViewControllerRouter {
    
    private let controller: SearchViewController
    private let characterBuilder: CharacterViewControllerBuilder?
    init(controller: SearchViewController,characterBuilder: CharacterViewControllerBuilder) {
        self.controller = controller
        self.characterBuilder = characterBuilder
    }
    
    func routeToCharacterViewController(characterId: Int) {
        if  let characterController = characterBuilder?.build(characterId: characterId) {
            controller.navigationController?.pushViewController(characterController, animated: true)
        }
    }
}
