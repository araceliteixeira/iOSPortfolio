//
//  DistancesViewController.swift
//  Assignment2
//
//  Created by Araceli Teixeira on 01/11/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class DistancesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblDistances: UITableView!
    
    struct DistanceCell {
        var from: String
        var to: String
        var distance: Int
    }
    
    var distances: [(String, String, Int)] = []
    var data: [DistanceCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
        
        tblDistances.delegate = self
        tblDistances.dataSource = self
    }
    
    func loadData() {
        for d in distances {
            data.append(DistanceCell(from: d.0, to: d.1, distance: d.2))
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceTableViewCell", for: indexPath) as? DistanceTableViewCell {
            cell.lblFrom?.text = data[indexPath.row].from
            cell.lblTo?.text = data[indexPath.row].to
            cell.lblDistance?.text = "\(data[indexPath.row].distance) km"
            
            return cell
        } else {
            fatalError("The dequeued cell is not an instance of DistanceTableViewCell")
        }
    }
}
