import UIKit

class CharacterControllerView: UIView {
    
    //MARK: - @IBOutlets
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    
    //MARK: - Methods 
    func setupCharacter(character: Character?) {
        guard let character = character else { return }
        guard let imageUrl = URL(string: character.image ) else { return }
        self.characterImageView.setImageWithUrl(imageUrl)
        self.nameLabel.text = character.name
        self.statusLabel.text = character.status.rawValue
        self.genderLabel.text = character.gender.rawValue
    }
}

