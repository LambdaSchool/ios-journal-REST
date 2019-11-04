//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Lisa Sampson on 8/16/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        entryController.createEntry(title: "Test 3", bodyText: "Lets try one more time.", completion: { (success) in
        //            DispatchQueue.main.async {
        //                self.tableView.reloadData()
        //            }
        //        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        entryController.fetchEntries { (success) in
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
        cell.entry = entry
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = entryController.entries[indexPath.row]
            entryController.delete(entry: entry) { (success) in
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? EntryDetailViewController {
            detailVC.entryController = entryController
            
            if segue.identifier == "ViewEntrySegue" {
                guard let index = tableView.indexPathForSelectedRow else { return }
                let entry = entryController.entries[index.row]
                detailVC.entry = entry
            }
        }
    }
    
    let entryController = EntryController()
    
}
