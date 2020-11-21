import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterStatusLabel: UILabel!
    
    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        characterImageView.layer.cornerRadius = characterImageView.bounds.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
        characterNameLabel.text = ""
        characterStatusLabel.text = ""
    }
}
