//
//  EntriesTableViewController.swift
//  Journal-REST
//
//  Created by Moses Robinson on 1/24/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        entryController.fetchEntries { (error) in
            if let error = error {
                NSLog("Could not fetch data: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryController.entries.count
    }
    
    let reuseIdentifier = "EntryCell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EntryTableViewCell
        
        let entry = entryController.entries[indexPath.row]
        cell.entry = entry
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let entry = entryController.entries[indexPath.row]
        
        if editingStyle == .delete {
            
            entryController.delete(entry: entry) { (error) in
                if let error = error {
                    NSLog("Could not delete entry: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateEntry" {
            guard let destination = segue.destination as? EntryDetailViewController else { return }
            
            destination.entryController = entryController
            
        } else if segue.identifier == "EntryDetail" {
            guard let destination = segue.destination as? EntryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            destination.entryController = entryController
            destination.entry = entryController.entries[indexPath.row]
        }
    }
    
    // MARK: - Properties
    
    let entryController = EntryController()
}
