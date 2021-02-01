//
//  ViewController.swift
//  Train-App
//
//  Created by Vicki Larkin on 12/01/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var stationListViewModel: StationListViewModel = StationListViewModel()
    var stations: [StationViewModel] = []
    var chosenStation: StationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stations = stationListViewModel.savedStations
        registerTableViewCells()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stations = stationListViewModel.savedStations
        tableView.reloadData()
    }
    
    func registerTableViewCells() {
        tableView.backgroundColor = .nightBlack
        let customCell = UINib(nibName: "StationNameViewCell", bundle: nil)
        tableView.register(customCell, forCellReuseIdentifier: "StationNameViewCell")
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showSearch", sender: nil)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
    }
    
    func updateDepartureStations(withStation: Station) {
        stations = stationListViewModel.savedStations
        tableView.reloadData()
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationListViewModel.savedStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationNameViewCell", for: indexPath) as! StationNameViewCell
        cell.selectionStyle = .none
        cell.trainStationName.text = stations[indexPath.row].name
        return cell 
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenStation = StationViewModel(name: stations[indexPath.row].name)
        performSegue(withIdentifier: "showDeparture", sender: nil)

    }
    
}

// MARK: - Navigation

extension HomeViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDeparture" {
            let viewController = segue.destination as! DeparturesViewController
            if let station = chosenStation {
                viewController.stationName = station.name
            }
        }
    }
    
}



