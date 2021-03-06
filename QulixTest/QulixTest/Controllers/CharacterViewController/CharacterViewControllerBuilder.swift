import Foundation
import UIKit

class CharacterViewControllerBuilder {
    func build(characterId: Int) -> CharacterViewController? {
        let searchBuilder = SearchViewControllerBuilder()
        let storyboard = UIStoryboard(name: "CharacterViewController", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "CharacterViewController") as? CharacterViewController else { return UIViewController() as? CharacterViewController }
        let router = CharacterViewControllerRouter(controller: controller, searchBuilder: searchBuilder)
        let viewModel = CharacterViewModel(router: router, characterId: characterId)
        controller.viewModel = viewModel
        return controller
    }
}
