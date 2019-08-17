//
//  TimeTableViewCell.swift
//  Train-App
//
//  Created by Vicki Larkin on 16/03/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var destinationNameLabel: UILabel!
    @IBOutlet weak var departTimeLabel: UILabel!
    @IBOutlet weak var platformNoLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = .nightBlack
        destinationNameLabel.textColor = .turquoise
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}


