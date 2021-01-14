import UIKit

class CharacterControllerView: UIView {
    
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    
    func setupCharacter(character: Character) {
        guard let imageUrl = URL(string: character.image ) else { return }
        characterImageView.setImageWithUrl(imageUrl)
        nameLabel.text = character.name
        statusLabel.text = character.status.rawValue
        genderLabel.text = character.gender.rawValue
    }
}
