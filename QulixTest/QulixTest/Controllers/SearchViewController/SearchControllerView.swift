import UIKit

enum SearchBarState {
    case isSearch
    case noSearch
}

class SearchControllerView: UIView{
    
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var searchBarRightConstraint: NSLayoutConstraint!
    
   
    func searchBarState(isSearch: SearchBarState){
        switch isSearch {
        case .isSearch:
            searchBarRightConstraint.constant = 0
            cancelButton.isHidden = true
            searchBar.endEditing(true)
            searchBar.text = ""
            charactersTableView.reloadData()
            break
        case .noSearch:
            searchBarRightConstraint.constant -= cancelButton.frame.width
            cancelButton.isHidden = false
        }
    }
    
    func setupUI(){
        cancelButton.isHidden = true
        noResultsLabel.isHidden = true
        noResultsLabel.text = "No results \n Try a new search"
    }
    
    func stopSearch(){
        noResultsLabel.isHidden = true
        searchBarState(isSearch: .isSearch)
    }
    
    func updateVeiwWithResult(result: Bool){
        noResultsLabel.isHidden = result
        charactersTableView.reloadData()
    }
}
