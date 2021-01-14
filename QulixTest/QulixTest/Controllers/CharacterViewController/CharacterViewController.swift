import UIKit

class CharacterViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: CharacterViewModel?
    
    //MARK: - Life cycle VC
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let character = viewModel?.character {
            controllerView.setupCharacter(character: character)
        }
    }
    
    //MARK: - @IBActions
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        viewModel?.openSearchViewController()
    }
}

extension CharacterViewController: ControllerView {
    typealias ControllerViewType = CharacterControllerView
}



