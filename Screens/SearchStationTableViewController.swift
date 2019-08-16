//
//  SearchStationTableViewController.swift
//  Train-App
//
//  Created by Vicki Larkin on 16/08/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import UIKit

class SearchStationTableViewController: UITableViewController {

    let stations = Stations().stations
    var filteredData: [(name: String, location: String)]!
    
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = stations
        registerTableViewCells()
        createSearchBar()
    }
    
    func registerTableViewCells() {
        tableView.backgroundColor = UIColor(red: 63/255, green: 62/255, blue: 72/255, alpha: 1)
        let customCell = UINib(nibName: "DepartureViewCell", bundle: nil)
        tableView.register(customCell, forCellReuseIdentifier: "cell")
    }
    
    
    func createSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        searchController.searchBar.isUserInteractionEnabled = true
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor(red: 61/255, green: 63/255, blue: 73/255, alpha: 1)
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.sizeToFit()
        let cancelButton = searchController.searchBar.value(forKeyPath: "cancelButton") as? UIButton
        cancelButton?.tintColor = UIColor.white
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DepartureViewCell
        cell.trainStationName.text = stations[indexPath.row].name
        cell.trainStationLocation.text = stations[indexPath.row].location
        return cell
    }

}

extension SearchStationTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
   
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("button pressed")
        dismiss(animated: true, completion: nil)
    }
}
