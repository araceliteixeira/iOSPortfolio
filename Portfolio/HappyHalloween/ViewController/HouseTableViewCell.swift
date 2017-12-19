//
//  HouseTableViewCell.swift
//  HappyHalloween
//
//  Created by Macstudent on 2017-11-01.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class HouseTableViewCell: UITableViewCell {

    @IBOutlet weak var imgHouse: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgRate: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
