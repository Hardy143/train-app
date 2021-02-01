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
    
    var departureListViewModel: DepartureListViewModel?
    var stationName: String?
    var departureItems: [TimeTableItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stationTitle.text = stationName
        configureTableView()
        registerTableViewCells()
        
        guard let stationName = stationName else { return }
        
        departureListViewModel = DepartureListViewModel(stationName: stationName)
        departureListViewModel?.parseUrl(completion: { timeTableItems in
            self.departureItems = timeTableItems
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
        return departureItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TimeTableViewCell
        cell.selectionStyle = .none
        
        guard let departureListViewModel = departureListViewModel else { return cell }
        
        let timeTableItemViewModel =  departureListViewModel.createTimeTableItem(destination: departureItems[indexPath.row].destination,
                                                              departTime: departureItems[indexPath.row].departTime,
                                                              platform: departureItems[indexPath.row].platform)
        
        cell.destinationNameLabel.text = timeTableItemViewModel.destination
        cell.departTimeLabel.text = timeTableItemViewModel.departTime
        cell.platformNoLabel.text = timeTableItemViewModel.platform

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
    
}
