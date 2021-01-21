import UIKit

enum SearchBarState {
    case isSearch
    case noSearch
    case searchPause
}

class SearchControllerView: UIView {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var noResultsLabel: UILabel!
    @IBOutlet private weak var searchBarRightConstraint: NSLayoutConstraint!
    
    
    var searchState: SearchBarState = .noSearch {
        didSet{
            if oldValue == .isSearch {
                searchBarRightConstraint.constant = 0
                cancelButton.isHidden = true
                searchBar.endEditing(true)
                charactersTableView.reloadData()
            } else {
                searchBarRightConstraint.constant -= cancelButton.frame.width
                cancelButton.isHidden = false
            }
        }
    }
    
    func setupUI() {
        switch searchState {
        case .noSearch:
            cancelButton.isHidden = true
            noResultsLabel.isHidden = true
            noResultsLabel.text = "No results \n Try a new search"
            charactersTableView.reloadData()
        case .isSearch: break 
        case .searchPause:
            searchBar.becomeFirstResponder()
        }
    }
    
    func stopSearch() {
        noResultsLabel.isHidden = true
        searchState = .isSearch
        searchBar.text = ""
    }
    
    func updateVeiwWithResult(result: Bool) {
        noResultsLabel.isHidden = result
        charactersTableView.reloadData()        
    }
}
