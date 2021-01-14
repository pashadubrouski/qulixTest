import UIKit

class SearchViewControllerBuilder {
    func build() -> UINavigationController? {
        let characterBuilder = CharacterViewControllerBuilder()
        let storyboard = UIStoryboard(name: "SearchViewController", bundle: nil)
        guard let destinationController = storyboard.instantiateViewController(identifier: "SearchViewController") as? UINavigationController
        else { return nil }
        guard let seacrhViewController = destinationController.viewControllers.first as? SearchViewController
        else { return nil }
        let router = SearchViewControllerRouter(controller: seacrhViewController, characterBuilder: characterBuilder)
        let viewModel = SearchViewModel(router: router)
        seacrhViewController.viewModel = viewModel
        return destinationController
    }
}
