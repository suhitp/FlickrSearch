//
//  SearchResultsViewController.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 08/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

class SearchResultsViewController: UITableViewController, UISearchResultsUpdating {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
    }
    
    //MARK: UITableviewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "result"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // MARK: UISearchResultsUpdating
    func filterContent(for searchText :String) {
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
        tableView.reloadData()
    }

}
