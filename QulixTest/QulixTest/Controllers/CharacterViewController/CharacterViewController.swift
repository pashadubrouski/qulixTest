import UIKit

class CharacterViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: CharacterViewModel!
    
    //MARK: - Life cycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getInfoAboutCharacter()
            self.viewModel.character.register { (character) in self.controllerView.setupCharacter(character: character) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    //MARK: - @IBActions
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        viewModel?.openSearchViewController()
    }
}

extension CharacterViewController: ControllerView {
    typealias ControllerViewType = CharacterControllerView
}



