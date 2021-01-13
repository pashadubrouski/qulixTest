import UIKit

final class CharacterViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!

    //MARK: - Properties
    var viewModel: CharacterViewModel?
    
    //MARK: - Life cycle VC
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupCharacter()
    }
    
    //MARK: - Methods
    private func setupCharacter(){
        characterImageView.image = viewModel?.image
        nameLabel.text = viewModel?.name
        statusLabel.text = viewModel?.status
        genderLabel.text = viewModel?.gender
    }
    
    //MARK: - @IBActions
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        viewModel?.openSearchViewController()
    }
}

extension CharacterViewController : ControllerView {
    typealias ControllerViewType = CharacterViewController
    
}
