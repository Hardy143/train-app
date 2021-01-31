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
    
    var timeTableCollection: TimeTableCollectionViewModel?
    var stationName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stationTitle.text = stationName
        configureTableView()
        registerTableViewCells()
        
        guard let stationName = stationName else { return }
        
        timeTableCollection = TimeTableCollectionViewModel(stationName: stationName)
        timeTableCollection?.parseUrl(completion: { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "returnHome", sender: nil)
    }
    
}

extension DeparturesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let timeTableItems = timeTableCollection?.timeTableItems {
            return timeTableItems.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TimeTableViewCell
        cell.selectionStyle = .none
        if let timeTableItems = timeTableCollection?.timeTableItems {
            let timeTableItemViewModel = createTimeTableItemViewModel(destination: timeTableItems[indexPath.row].destination,
                                                                  departTime: timeTableItems[indexPath.row].departTime,
                                                                  platform: timeTableItems[indexPath.row].platform)
            cell.destinationNameLabel.text = timeTableItemViewModel.destination
            cell.departTimeLabel.text = timeTableItemViewModel.departTime
            cell.platformNoLabel.text = timeTableItemViewModel.platform
        }

        return cell
    }
    
}

// MARK: - Private methods

extension DeparturesViewController {
    
    private func configureTableView() {
        tableView.backgroundColor = .nightBlack
        tableView.separatorStyle = .none
    }
    
    private func registerTableViewCells() {
        let customCell = UINib(nibName: "TimeTableViewCell", bundle: nil)
        tableView.register(customCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func createTimeTableItemViewModel(destination: String, departTime: String, platform: String) -> TimeTableItemViewModel {
        
        let timeTableItem = TimeTableItem(destination: destination, departTime: departTime, platform: platform)
        return TimeTableItemViewModel(timeTableItem: timeTableItem)
    }
    
}
