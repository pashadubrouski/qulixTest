import UIKit
import Foundation
import Combine

class SearchViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: SearchViewModel!
    
    var publisher: NotificationCenter.Publisher?
    var cancellable: AnyCancellable?
    //MARK: - Life cycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.characters.register({ characters in self.update(characters: characters) })
           setupSearchBarObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        controllerView.setupUI()
    }
    
    //MARK: - Methods
    
    fileprivate func setupSearchBarObserver() {
        self.publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification , object: controllerView.searchBar.searchTextField)
        publisher.map {
            (($0.object as! UISearchTextField).text)
        }
        .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
        .removeDuplicates()
        
        cancellable = publisher.sink(receiveValue: { (searchText) in
            print("123")
//            guard let name = searchText else { return }
//            viewModel.searchCharacters(name: name)
        })
    }
    
    private func stopSearch() {
        viewModel.stopSearch()
        controllerView.stopSearch()
        controllerView.searchState = .noSearch
        controllerView.openedFromVc = false
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
        //controllerView.searchState = .searchPause
        controllerView.openedFromVc = true 
    }
}

//MARK: - SearchBarDelegate extension 

extension SearchViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if controllerView.openedFromVc != true { controllerView.searchState = .isSearch } 
        
    }
    
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard let textString = searchBar.text, let name = textString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        }
}

extension SearchViewController: ControllerView {
    typealias ControllerViewType = SearchControllerView
}


