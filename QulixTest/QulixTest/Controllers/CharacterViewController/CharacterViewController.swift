import UIKit

final class CharacterViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!

    //MARK: - Properties
    var image: UIImage?
    var name: String?
    var status: String?
    var gender: String?
    
    //MARK: - Life cycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharacter()
    }
    
    //MARK: - Methods
    private func setupCharacter(){
        characterImageView.image = image
        nameLabel.text = name
        statusLabel.text = status
        genderLabel.text = gender
    }
    
    //MARK: - @IBActions
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

