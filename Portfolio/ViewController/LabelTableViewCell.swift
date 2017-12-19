//
//  LabelTableViewCell.swift
//  Portfolio
//
//  Created by Araceli Teixeira on 19/12/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
