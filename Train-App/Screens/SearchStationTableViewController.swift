//
//  SearchStationTableViewController.swift
//  Train-App
//
//  Created by Vicki Larkin on 16/08/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import UIKit

protocol SearchDelegate: class {
    func updateDepartureStations(withStation: Station)
}

class SearchStationTableViewController: UITableViewController {

    var stations: [String] = []
    var filteredData: [String] = []
    var chosenStation: Station?
    var searchController: UISearchController!
    weak var delegate: SearchDelegate?

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
        let customCell = UINib(nibName: "StationNameViewCell", bundle: nil)
        tableView.register(customCell, forCellReuseIdentifier: "StationNameViewCell")
    }
    
    func configureTableView() {
        tableView.backgroundColor = .nightBlack
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
        searchBackground?.textColor = .lightGray
        searchBackground?.backgroundColor = .nightBlack
        cancelButton?.tintColor = .salmonRed
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredData.count
        }
        
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationNameViewCell", for: indexPath) as! StationNameViewCell
        cell.selectionStyle = .none
        
        if searchController.isActive {
            cell.trainStationName.text = filteredData[indexPath.row]
            return cell
        }
        
        cell.trainStationName.text = stations[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive {
            chosenStation = Station(name: filteredData[indexPath.row])
        } else {
            chosenStation = Station(name: stations[indexPath.row])
        }
        
        performSegue(withIdentifier: "showDepartureInfo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDepartureInfo" {
            let viewController = segue.destination as! DeparturesViewController
            if let station = chosenStation {
                viewController.stationName = station.name
            }
        }
    }
}

extension SearchStationTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? stations : stations.filter({ (dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil
            })
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}
