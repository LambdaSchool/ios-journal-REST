//
//  EntriesListTableViewController.swift
//  Journal
//
//  Created by Jason Modisett on 9/13/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

class EntriesListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        entryController.fetchEntries { (error) -> (Void) in
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryController.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.entries.rawValue, for: indexPath) as? EntryTableViewCell else { return UITableViewCell() }
        
        let entry = entryController.entries[indexPath.row]
        cell.entry = entry
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = entryController.entries[indexPath.row]
            entryController.delete(entry: entry) { (error) -> (Void) in
                DispatchQueue.main.async {
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? EntryDetailsViewController else { return }
        
        destVC.entryController = entryController
        
        if segue.identifier == SegueIdentifiers.toEntryDetails.rawValue {
            guard let indexPath = tableView.indexPathForSelectedRow else
            { return }
            destVC.entry = entryController.entries[indexPath.row]
        }
    }
    

    let entryController = EntryController()
    
}
