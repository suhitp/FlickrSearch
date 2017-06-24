//
//  SearchResultsViewController.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 08/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit
import Foundation

public protocol SearchResultSelectionProtocol: class {
    func didSelectSearchText(_ searchText: String)
}

class SearchResultsViewController: UITableViewController, UISearchResultsUpdating {

    weak var searchDelegate: SearchResultSelectionProtocol?
    lazy var searchResults: [String] = self.getSearchResultData()
    var filteredArray: [String] = []
    var shouldShowFilteredResults: Bool =  false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.searchReuseIdentifier)
        shouldShowFilteredResults = false
        tableView.tableFooterView = UIView()
    }
    
    private func getSearchResultData() -> [String] {
        return DataManager.flickrSearchData
    }
    
    //MARK: UITableviewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchReuseIdentifier, for: indexPath)
        if shouldShowFilteredResults {
            cell.textLabel?.text = filteredArray[indexPath.row]
        } else {
            cell.textLabel?.text = searchResults[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowFilteredResults {
            return filteredArray.count
        } else {
            return searchResults.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var text = ""
        if shouldShowFilteredResults {
            text = filteredArray[indexPath.row]
        } else {
             text = searchResults[indexPath.row]
        }
        
        if text.isEmpty { return }
        DataManager.saveSearchText(text)
        searchDelegate?.didSelectSearchText(text)
    }
    
    // MARK: UISearchResultsUpdating
    func filterContent(for searchText :String) {
    }
    
    func updateSearchResults(for searchController: UISearchController) {
       
        searchController.searchResultsController?.view.isHidden = false
        
        guard let searchString = searchController.searchBar.text else {
            shouldShowFilteredResults = false
            tableView.reloadData()
            return
        }
        
        filteredArray = searchResults.filter{
           return $0.caseInsensitiveCompare(searchString) == .orderedSame
        }
    
        if filteredArray.isEmpty {
            shouldShowFilteredResults = false
            tableView.reloadData()
            return
        }
        
        shouldShowFilteredResults = true
        tableView.reloadData()
    }
}

extension SearchResultsViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let _ = searchBar.text else {
            return
        }
        shouldShowFilteredResults = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowFilteredResults = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        searchBar.resignFirstResponder()
        DataManager.saveSearchText(text)
        searchDelegate?.didSelectSearchText(text)
    }
}
