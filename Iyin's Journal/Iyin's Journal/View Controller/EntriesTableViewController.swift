//
//  EntriesTableViewController.swift
//  Iyin's Journal
//
//  Created by Iyin Raphael on 8/16/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        entryController.fetchEntries { (error) in
            if let error = error {
                NSLog("Error fetching at viewWillAppear: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
            
        
    }
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entryController.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EntryTableViewCell else {return  UITableViewCell()}
        cell.entry = entryController.entries[indexPath.row]
        return cell
    }


 

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let entry = entryController.entries[indexPath.row]
            entryController.deleteEntry(entry: entry ) { (error) in
                if let error = error{
                    NSLog("Error deleting entry: \(error)")
                }
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                
            }
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? EntryDetailViewController else {return}
        destinationVC.entryController = entryController
        
        if segue.identifier == "ShowDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            destinationVC.entry = entryController.entries[indexPath.row]
            
        }
     
    }

    
    var entryController = EntryController()

}
