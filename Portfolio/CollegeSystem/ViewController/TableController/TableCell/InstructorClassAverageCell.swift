//
//  InstructorClassAverageCell.swift
//  CollegeSystem
//
//  Created by MacStudent on 2017-11-04.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class InstructorClassAverageCell: UITableViewCell {

    @IBOutlet weak var lblInstructor: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var lblAverage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
