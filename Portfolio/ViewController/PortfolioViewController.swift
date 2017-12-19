//
//  PortfolioViewController.swift
//  Portfolio
//
//  Created by Araceli Teixeira on 19/12/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class PortfolioViewController: UITableViewController {
    private let projects: [String] = ["Project Vehicles", "Countries and Neighbours", "Happy Halloween"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rawCell = tableView.dequeueReusableCell(withIdentifier: "labelTableViewCell", for: indexPath)
        
        if let cell = rawCell as? LabelTableViewCell {
            cell.titleLabel.text = projects[indexPath.row]
            return cell
        } else {
            print("Not possible convert the cell to LabelTableViewCell")
            return rawCell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var segueId: String = ""
        
        switch indexPath.row {
        case 0:
            segueId = "showProjectVehicles"
        case 1:
            segueId = "showCountriesAndNeighbours"
        case 2:
            segueId = "showHappyHalloween"
        default:
            print("No specific action.")
        }
        
        if !segueId.isEmpty {
            self.performSegue(withIdentifier: segueId, sender: self)
        }
    }
}
