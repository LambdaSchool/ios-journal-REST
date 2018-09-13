//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Dillon McElhinney on 9/13/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    // MARK: - Properties
    var journalController: JournalController?
    var journal: Journal?

    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryTableViewCell
        let entry = journal?.sortedEntries[indexPath.row]
        
        cell.entry = entry

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = journal else { return }
            let entry = journal.sortedEntries[indexPath.row]
            
            journalController?.deleteEntry(journal: journal, entry: entry) { (error) in
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddEntrySegue" {
            let destinationVC = segue.destination as! EntryDetailViewController
            
            destinationVC.journalController = journalController
            destinationVC.journal = journal
        } else if segue.identifier == "ShowEntrySegue" {
            guard let destincationVC = segue.destination as? EntryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow, let journal = journal else { return }
            let entry = journal.sortedEntries[indexPath.row]
            
            
            destincationVC.entry = entry
            destincationVC.journal = journal
            destincationVC.journalController = journalController
        }
    }

    // MARK: - Utility Methods
    private func updateViews() {
        guard let journal = journal else { return }
        
        title = journal.title
    }
    
}
