import Foundation
import UIKit

class CharacterViewModel {
    
    var character: Character?
    
    private let router: CharacterViewControllerRouter
    init(router: CharacterViewControllerRouter) {
        self.router = router
    }
    
    func openSearchViewController() {
        router.routeToSearchViewController()
    }
}
