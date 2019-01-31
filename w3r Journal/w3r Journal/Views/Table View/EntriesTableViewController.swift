//
//  EntriesTableViewController.swift
//  w3r Journal
//
//  Created by Michael Flowers on 1/31/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {

    var ec = EntryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ec.fetchEntries { (error) in
            if let error = error {
                print("Error calling fetchEntries method: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ec.fetchEntries { (error) in
            if let error = error {
                print("Error calling fetchEntries method: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ec.entries.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EntryTableViewCell
        
        //pass an entry to the tableViewCell's file
        let entryToPass = ec.entries[indexPath.row]
        cell.entry = entryToPass
        // Configure the cell...

        return cell
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "addSegue" {
            guard let toDestinationVc = segue.destination as? EntryDetailViewController else { return }
            toDestinationVc.ec = ec
        } else if segue.identifier == "cellSegue" {
            guard let toDestinationVc = segue.destination as? EntryDetailViewController, let index = tableView.indexPathForSelectedRow else { return }
            let passThisEntry = ec.entries[index.row]
            toDestinationVc.entry = passThisEntry
            toDestinationVc.ec = ec
        }
    }
}
