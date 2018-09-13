//
//  JournalsTableViewController.swift
//  Journal
//
//  Created by Dillon McElhinney on 9/13/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class JournalsTableViewController: UITableViewController {
    
    // MARK: - Properties
    let journalController = JournalController()
    
    // Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        journalController.fetchJournals() { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UI Methods
    @IBAction func addJournal(_ sender: Any) {
        presentAddJournalAlert()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalController.journals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath)
        let journal = journalController.sortedJournals[indexPath.row]
        
        cell.textLabel?.text = journal.title
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let journal = journalController.sortedJournals[indexPath.row]
            
            journalController.deleteJournal(journal) { (_) in
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowJournalSegue" {
            guard let destinationVC = segue.destination as? EntriesTableViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            let journal = journalController.sortedJournals[indexPath.row]
            
            destinationVC.journalController = journalController
            destinationVC.journal = journal
            
        }
    }
    
    // MARK: - Utility Methods
    private func presentAddJournalAlert() {
        let alertController = UIAlertController(title: "Want to add a new journal?", message: nil, preferredStyle: .alert)
        var titleTextField = UITextField()
        alertController.addTextField { (textField) in
            titleTextField = textField
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        let addJournal = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let journalTitle = titleTextField.text else { return }
            
            self.journalController.createJournal(title: journalTitle, completion: { (_) in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        
        alertController.addAction(dismissAction)
        alertController.addAction(addJournal)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
