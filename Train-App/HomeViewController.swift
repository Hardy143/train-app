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
    @IBOutlet weak var searchView: UIView!
    
    let data = ["a", "b", "c", "d", "e"]
    var filteredData: [String]!
    var searchController: UISearchController!
    
    let parser = Parser()
    var timeTableItem: [TimeTableItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = data

        
//        parser.parse(url: TrainAPIEndpoints.bangor) { timeTableData in
//            self.timeTableItem = timeTableData
//            print(self.timeTableItem)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }

        registerTableViewCells()
    }
    
    func registerTableViewCells() {
        tableView.backgroundColor = UIColor(red: 63/255, green: 62/255, blue: 72/255, alpha: 1)
        let customCell = UINib(nibName: "DepartureViewCell", bundle: nil)
        tableView.register(customCell, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DepartureViewCell
        cell.trainStationName.text = "Bangor Train Station"
        cell.trainStationLocation.text = "Bangor"
        return cell 
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}


