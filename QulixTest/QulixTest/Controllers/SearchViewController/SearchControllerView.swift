import UIKit

enum SearchBarState {
    case isSearch
    case noSearch
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
                searchBar.text = ""
                charactersTableView.reloadData()
            } else {
                searchBarRightConstraint.constant -= cancelButton.frame.width
                cancelButton.isHidden = false
            }
        }
    }
    
    func setupUI() {
        cancelButton.isHidden = true
        noResultsLabel.isHidden = true
        noResultsLabel.text = "No results \n Try a new search"
        charactersTableView.reloadData()
    }
    
    func stopSearch() {
        noResultsLabel.isHidden = true
        searchState = .isSearch
    }
    
    func updateVeiwWithResult(result: Bool) {
        noResultsLabel.isHidden = result
        charactersTableView.reloadData()
    }
    
}
