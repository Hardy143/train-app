//
//  ViewController.swift
//  Train-App
//
//  Created by Vicki Larkin on 12/01/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, SearchDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var stations: [Station] = []
    var chosenStation: Station?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTableViewCells()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        stations.append(withStation)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSearch" {
            let popoverViewController = segue.destination as! SearchStationTableViewController
            popoverViewController.delegate = self
        }
        
        if segue.identifier == "showDepartureInfo" {
            let viewController = segue.destination as! DeparturesViewController
            if let station = chosenStation {
                viewController.stationName = "\(station.name) Departures"
            }
        }
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
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
        chosenStation = Station(name: stations[indexPath.row].name)
        performSegue(withIdentifier: "showDepartureInfo", sender: nil)
    }
    
}



