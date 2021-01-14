import Foundation
import UIKit

class CharacterViewControllerRouter {
    
    private let controller: CharacterViewController
    private let searchBuilder: SearchViewControllerBuilder
    
    init(controller: CharacterViewController, searchBuilder: SearchViewControllerBuilder) {
        self.controller = controller
        self.searchBuilder = searchBuilder
    }
    
    func routeToSearchViewController() {
        controller.navigationController?.popViewController(animated: true)
    }
}
