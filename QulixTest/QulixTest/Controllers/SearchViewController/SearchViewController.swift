import UIKit

class SearchViewController: UIViewController, Observer {
    
    
    //MARK: - Properties
    var viewModel: SearchViewModel?
    
    
    
   
    //MARK: - Life cycle VC
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel?.register(observer: self)
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        controllerView.setupUI()
    }
    
    //MARK: - Methods
    private func stopSearch() {
        viewModel?.stopSearch()
        controllerView.stopSearch()
        controllerView.searchState = .noSearch
    }
    
    func update(searchCharacters: [Character]?) {
        var result: Bool = false
        if let charactersResult = searchCharacters {
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
        return viewModel?.searchResult?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        guard let character = viewModel?.searchResult?.results[indexPath.row]
        else { return UITableViewCell() }
        let imageUrl = URL(string: (character.image))!
        cell.characterImageView.setImageWithUrl(imageUrl)
        cell.characterNameLabel.text = character.name
        cell.characterStatusLabel.text = character.status.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.openCharacterVC(index: indexPath.row)
        stopSearch()
    }
}

//MARK: - SearchBarDelegate extension 

extension SearchViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        controllerView.searchState = .isSearch
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let textString = searchBar.text, let urlString = textString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
//        viewModel?.searchUsers(urlString: urlString, coplition: { (result) in
//                        DispatchQueue.main.async {
//                            self.controllerView.updateVeiwWithResult(result: result)
//                        }
//        })
        viewModel?.searchUsers(urlString: urlString)
    }
}

extension SearchViewController: ControllerView {
    typealias ControllerViewType = SearchControllerView
}


