import UIKit

class SearchViewControllerRouter {
    
    private let controller: SearchViewController
    private let characterBuilder: CharacterViewControllerBuilder?
    init(controller: SearchViewController,characterBuilder: CharacterViewControllerBuilder) {
        self.controller = controller
        self.characterBuilder = characterBuilder
    }
    
    func routeToCharacterViewController(character: Character) {
        if  let characterController = characterBuilder?.build() {
            guard let imageUrl = URL(string: (character.image)) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) else { return }
//            characterController.viewModel?.image = image
//            characterController.viewModel?.name = name
//            characterController.viewModel?.status = status
//            characterController.viewModel?.gender = gender
            characterController.viewModel?.image = image
            characterController.viewModel?.name = character.name
            characterController.viewModel?.status = character.status.rawValue
            characterController.viewModel?.gender = character.status.rawValue
            controller.navigationController?.pushViewController(characterController, animated: true)
        }
    }
}
