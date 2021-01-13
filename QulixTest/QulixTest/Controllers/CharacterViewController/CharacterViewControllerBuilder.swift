import Foundation
import UIKit

class CharacterViewControllerBuilder {
    func build() -> CharacterViewController? {
        let searchBuilder = SearchViewControllerBuilder()
        let storyboard = UIStoryboard(name: "CharacterViewController", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "CharacterViewController") as? CharacterViewController else{
            return UIViewController() as! CharacterViewController
        }
        let router = CharacterViewControllerRouter(controller: controller, searchBuilder: searchBuilder)
        let viewModel = CharacterViewModel(router: router)
        controller.viewModel = viewModel
        return controller
    }
}
