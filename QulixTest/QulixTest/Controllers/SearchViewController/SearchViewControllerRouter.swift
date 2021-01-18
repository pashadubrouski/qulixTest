import UIKit

class SearchViewControllerRouter {
    
    private let controller: SearchViewController
    private let characterBuilder: CharacterViewControllerBuilder?
    init(controller: SearchViewController,characterBuilder: CharacterViewControllerBuilder) {
        self.controller = controller
        self.characterBuilder = characterBuilder
    }
    
    func routeToCharacterViewController(character: Character) { // TODO: 1)передавать id в builder 
        if  let characterController = characterBuilder?.build() {
            characterController.viewModel?.character = character
            controller.navigationController?.pushViewController(characterController, animated: true)
        }
    }
}
