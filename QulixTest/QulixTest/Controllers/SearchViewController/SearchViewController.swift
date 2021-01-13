import UIKit

class SearchViewController: UIViewController {
    
    
    //MARK: - Properties
    private var searchState: SearchBarState = .noSearch
    var viewModel: SearchViewModel?
    
    //MARK: - Life cycle VC
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        controllerView.setupUI()
        print("itswork")
    }

    //MARK: - @IBActions
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        viewModel?.searchCharacters.removeAll()
        controllerView.stopSearch()
        searchState = .noSearch
    }
}

//MARK: - tableView dataSourse&delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.searchCharacters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        let imageUrl = URL(string: (viewModel?.searchCharacters[indexPath.row].image)!)!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageUrl ) else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                cell.characterImageView.image = image
            }
        }
        cell.characterNameLabel.text = viewModel?.searchCharacters[indexPath.row].name
        cell.characterStatusLabel.text = viewModel?.searchCharacters[indexPath.row].status.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.openCharacterVC(index: indexPath.row)
        
    }
}

//MARK: - SearchBarDelegate extension 

extension SearchViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        controllerView.searchBarState(isSearch: searchState)
        searchState = .isSearch
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let textString = searchBar.text, let urlString = textString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        viewModel?.searchUsers(urlString: urlString, coplition: { (result) in
            DispatchQueue.main.async {
                self.controllerView.updateVeiwWithResult(result: result)
            }
        })
    }
}

extension SearchViewController: ControllerView {
    typealias ControllerViewType = SearchControllerView
}


