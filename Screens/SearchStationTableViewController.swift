//
//  SearchStationTableViewController.swift
//  Train-App
//
//  Created by Vicki Larkin on 16/08/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import UIKit

class SearchStationTableViewController: UITableViewController {

    var stations: [String] = []
    var filteredData: [(name: String, location: String)]!
    var chosenStation: Station?
    var searchController: UISearchController!
    var delegate: HomeViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        configureTableView()
        createSearchBar()
        JsonParser().fetchRailwayStationsFromAPI { (stations) in
            self.stations = stations
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func registerTableViewCells() {
        let customCell = UINib(nibName: "DepartureViewCell", bundle: nil)
        tableView.register(customCell, forCellReuseIdentifier: "cell")
    }
    
    func configureTableView() {
        tableView.backgroundColor = .slateGray
        tableView.separatorStyle = .none
    }
    
    func createSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        searchController.searchBar.isUserInteractionEnabled = true
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = .slateGray
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.sizeToFit()
        let cancelButton = searchController.searchBar.value(forKeyPath: "cancelButton") as? UIButton
        let searchBackground = searchController.searchBar.value(forKeyPath: "searchField") as? UITextField
        searchBackground?.backgroundColor = .nightBlack
        cancelButton?.tintColor = .salmonRed
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
        cell.trainStationName.text = stations[indexPath.row]
        //cell.trainStationLocation.text = stations[indexPath.row].location
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //chosenStation = Station(name: stations[indexPath.row].name, location: stations[indexPath.row].location)
        if let station = chosenStation {
            delegate?.updateDepartureStations(withStation: station)
            self.dismiss(animated: true, completion: nil)
        }
        
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
