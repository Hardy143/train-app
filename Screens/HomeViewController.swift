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
    
    let parser = Parser()
    var stations: [Station] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        parser.parse(url: TrainAPIEndpoints.bangor) { timeTableData in
//            self.timeTableItem = timeTableData
//            print(self.timeTableItem)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }

        registerTableViewCells()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func registerTableViewCells() {
        tableView.backgroundColor = .slateGray
        let customCell = UINib(nibName: "StationNameViewCell", bundle: nil)
        tableView.register(customCell, forCellReuseIdentifier: "cell")
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
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StationNameViewCell
        cell.trainStationName.text = stations[indexPath.row].name
       // cell.trainStationLocation.text = stations[indexPath.row].location
        return cell 
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}



