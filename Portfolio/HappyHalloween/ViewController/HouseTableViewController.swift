//
//  HouseTableViewController.swift
//  HappyHalloween
//
//  Created by Macstudent on 2017-11-01.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class HouseTableViewController: UITableViewController {

    var data: [House] = []
    var house: House?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = UIColor.orange
        loadData()
    }

    func loadData() {
        data.append(House("10 Witch Avenue", 3, UIImage(named: "house1")))
        data.append(House("20 Spooky Crescent", 1, UIImage(named: "house2")))
        data.append(House("30 Lizzard Street", 7, UIImage(named: "house3")))
        data.append(House("40 Skeleton Road", 4, UIImage(named: "house4")))
        data.append(House("50 Dragon Boulevard", 5, UIImage(named: "house5")))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell", for: indexPath) as? HouseTableViewCell)!
        cell.imgHouse.image = data[indexPath.row].imgHouse
        cell.lblAddress.text = data[indexPath.row].address
        cell.imgRate.image = data[indexPath.row].imgRate

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "addItem":
            print("Adding a new house.")
        case "showDetail":
            if let houseViewController = segue.destination as? HalloweenViewController {
                if let selectedHouseCell = sender as? HouseTableViewCell {
                    if let indexPath = tableView.indexPath(for: selectedHouseCell){
                        let selectedHouse = data[indexPath.row]
                        houseViewController.house = selectedHouse
                    } else {
                        fatalError("The selected cell is not being displayed by the table")
                    }
                } else {
                    fatalError("Unexpected sender: \(sender!)")
                }
            } else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "")")
        }
    }

    @IBAction func unwindToHouseList(sender: UIStoryboardSegue) {
        if let source = sender.source as? HalloweenViewController {
            if let newHouse = source.house {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    data[selectedIndexPath.row] = newHouse
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                } else {
                    let newIndexPath = IndexPath(row: data.count, section: 0)
                    data.append(newHouse)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
