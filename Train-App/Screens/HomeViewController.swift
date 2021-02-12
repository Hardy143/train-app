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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.backgroundColor = .nightBlack
        let customCell = UINib(nibName: "StationNameViewCell", bundle: nil)
        tableView.register(customCell, forCellReuseIdentifier: "StationNameViewCell")
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showSearch", sender: nil)
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            chosenStation = StationViewModel(name: stations[indexPath.row].name)
            guard let station = chosenStation else {
                print("Station to delete is nil")
                return
            }
            
            station.deleteStation()
            stations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        
        }
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
    
    @IBAction func unwind(_ seg: UIStoryboardSegue) {
        
    }
    
}



