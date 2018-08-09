//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Jeremy Taylor on 8/9/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    let entryController = EntryController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        entryController.fetchEntries { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return entryController.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryTableViewCell
        let entry = entryController.entries[indexPath.row]

        // Configure the cell...
        
        cell.entry = entry

        return cell
    }
    


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let entry = entryController.entries[indexPath.row]
            entryController.delete(entry: entry) { (error) in
                if let error = error {
                    NSLog("Couldn't delete entry: \(error)")
                }
            }
            DispatchQueue.main.async {
                self.entryController.entries.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddEntry" {
            let destVC = segue.destination as! EntryDetailViewController
            destVC.entryController = entryController
        }
        if segue.identifier == "ShowEntry" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let entry = entryController.entries[indexPath.row]
            let destVC = segue.destination as! EntryDetailViewController
            destVC.entryController = entryController
            destVC.entry = entry
        }
    }
}
