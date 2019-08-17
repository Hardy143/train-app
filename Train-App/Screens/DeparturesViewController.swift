//
//  DeparturesViewController.swift
//  Train-App
//
//  Created by Vicki Larkin on 17/08/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import UIKit

class DeparturesViewController: UIViewController {
    
    @IBOutlet weak var stationTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var stationName: String!
    let parser = Parser()
    
    var timeTableItems: [TimeTableItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stationTitle.text = stationName
        configureTableView()
        registerTableViewCells()
        
        let apiURL = TrainAPIEndpoints.getAPI(stationName: stationName)
        parser.parse(url: apiURL) { timeTableData in
            self.timeTableItems = timeTableData
            print(self.timeTableItems)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }
    
    func configureTableView() {
        tableView.backgroundColor = .nightBlack
        tableView.separatorStyle = .none
    }
    
    func registerTableViewCells() {
        let customCell = UINib(nibName: "TimeTableViewCell", bundle: nil)
        tableView.register(customCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension DeparturesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeTableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TimeTableViewCell
        cell.selectionStyle = .none
        cell.destinationNameLabel.text = timeTableItems[indexPath.row].destination
        cell.departTimeLabel.text = timeTableItems[indexPath.row].departTime
        cell.platformNoLabel.text = timeTableItems[indexPath.row].platform
        return cell
    }
    
    
}
