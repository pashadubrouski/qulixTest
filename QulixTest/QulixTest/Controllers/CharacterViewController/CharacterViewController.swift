import UIKit
import Combine

class CharacterViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: CharacterViewModel!
    var characterCancallable: AnyCancellable?
    
    //MARK: - Life cycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getInfoAboutCharacter()
        characterCancallable = self.viewModel.character.publisher.sink { (character) in
            self.controllerView.setupCharacter(character: character)
        }
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



