//
//  EntriesTableViewController.swift
//  JournalREST
//
//  Created by Ilgar Ilyasov on 9/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let entryController = EntryController()
    
    
    // MARK: Application lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        entryController.fetchEntries { (_) in
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryTableViewCell else { return UITableViewCell() }
        
        let theEntry = entryController.entries[indexPath.row]
        cell.entry = theEntry
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let index = tableView.indexPathForSelectedRow else { return }
            entryController.entries.remove(at: index.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBarButtonSegue" {
            let destinationVC = segue.destination as! EntryDetailViewController
            destinationVC.entryController = entryController
            
        } else if segue.identifier == "TableCellSegue" {
            let destinationVC = segue.destination as! EntryDetailViewController
            destinationVC.entryController = entryController
            
            guard let index = tableView.indexPathForSelectedRow else { return }
            let theEntry = entryController.entries[index.row]
            
            destinationVC.entry = theEntry
        }
    }
}
