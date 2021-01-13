import Foundation
import UIKit

class CharacterViewModel {
    
    var image: UIImage?
    var name: String?
    var status: String?
    var gender: String?
    
    private let router: CharacterViewControllerRouter
    init(router: CharacterViewControllerRouter) {
        self.router = router
    }
    
    func openSearchViewController() {
        router.routeToSearchViewController()
    }
    
}
