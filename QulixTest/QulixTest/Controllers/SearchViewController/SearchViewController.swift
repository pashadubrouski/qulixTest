import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: - @IBOutlets
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var charactersTableView: UITableView!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var searchBarRightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var noResultsLabel: UILabel!
    
    //MARK: - Properties
    private var searchResult: Result?
    private var searchCharacters: [Character] = []
    private var isSearch = false
    private lazy var charactersService: CharacterServiceProtocol = {
        return CharactersService()
    }()
    
    //MARK: - Life cycle VC
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupUI()
    }
    
    //MARK: - Methods
    private func setupUI(){
        navigationController?.navigationBar.isHidden = true
        cancelButton.isHidden = true
        noResultsLabel.isHidden = true
        noResultsLabel.text = "No results \n Try a new search"
    }
    
    private func searchCharacter(isSearch: Bool){
        if !isSearch{
            searchBarRightConstraint.constant -= cancelButton.frame.width
            cancelButton.isHidden = false
            self.isSearch = true
        }else {
            searchBarRightConstraint.constant = 0
            cancelButton.isHidden = true
            self.isSearch = false
            searchBar.endEditing(true)
            searchCharacters.removeAll()
            searchBar.text = ""
            charactersTableView.reloadData()
        }
    }
    
    private func openCharacterVC(image: UIImage, name: String,status: String, gender: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let characterController = storyboard.instantiateViewController(withIdentifier: "CharacterViewController") as? CharacterViewController else { return }
        characterController.image = image
        characterController.name = name
        characterController.status = status
        characterController.gender = gender
        navigationController?.pushViewController(characterController, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchCharacter(isSearch: isSearch)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let textString = searchBar.text, let urlString = textString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        charactersService.getCharacters(with: urlString) { (result, error) in
            guard let result = result, result.results.count > 0, error == nil else {
                self.searchCharacters = []
                DispatchQueue.main.async {
                    self.charactersTableView.reloadData()
                    self.noResultsLabel.isHidden = false
                }
                return
            }
            self.searchResult = result
            self.searchCharacters = result.results
            DispatchQueue.main.async {
                self.charactersTableView.reloadData()
                self.noResultsLabel.isHidden = true
            }
        }
    }
    
    //MARK: - @IBActions
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        searchCharacter(isSearch: isSearch)
        noResultsLabel.isHidden = true
    }
    
}

//MARK: - tableView dataSourse&delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        let imageUrl = URL(string: searchCharacters[indexPath.row].image)!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageUrl ) else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                cell.characterImageView.image = image
            }
        }
        cell.characterNameLabel.text = searchCharacters[indexPath.row].name
        cell.characterStatusLabel.text = searchCharacters[indexPath.row].status.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let imageUrl = URL(string: searchCharacters[indexPath.row].image) else { return }
        guard let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) else { return }
        openCharacterVC(image: image, name: searchCharacters[indexPath.row].name, status: searchCharacters[indexPath.row].status.rawValue, gender: searchCharacters[indexPath.row].gender.rawValue)
    }
}


