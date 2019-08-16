//
//  DepartureViewCell.swift
//  Train-App
//
//  Created by Vicki Larkin on 20/07/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import UIKit

class DepartureViewCell: UITableViewCell {

    @IBOutlet weak var trainStationName: UILabel!
    @IBOutlet weak var trainStationLocation: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.applyShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
