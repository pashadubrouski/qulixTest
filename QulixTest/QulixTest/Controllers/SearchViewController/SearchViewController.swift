import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: SearchViewModel!
    
    //MARK: - Life cycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.characters.register({ characters in self.update(characters: characters) })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        controllerView.setupUI()
    }
    
    //MARK: - Methods
    private func stopSearch() {
        viewModel.stopSearch()
        controllerView.stopSearch()
        controllerView.searchState = .noSearch
    }
    
    func update(characters: [Character]?) {
        var result: Bool = false
        if let charactersResult = characters {
            result = charactersResult.count > 0
        }
        self.controllerView.updateVeiwWithResult(result: result)
    }
    
    //MARK: - @IBActions
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        stopSearch()
    }
}

//MARK: - tableView dataSourse&delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        guard let character = viewModel?.characters.data?[indexPath.row]
        else { return UITableViewCell() }
        let imageUrl = URL(string: (character.image))!
        cell.characterImageView.setImageWithUrl(imageUrl)
        cell.characterNameLabel.text = character.name
        cell.characterStatusLabel.text = character.status.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openCharacterVC(index: indexPath.row)
        controllerView.searchState = .searchPause
    
    }
}

//MARK: - SearchBarDelegate extension 

extension SearchViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        controllerView.searchState = .isSearch
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let textString = searchBar.text, let name = textString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        viewModel.searchCharacters(name: name)
    }
}

extension SearchViewController: ControllerView {
    typealias ControllerViewType = SearchControllerView
}


