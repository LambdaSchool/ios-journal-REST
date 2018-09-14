//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Moin Uddin on 9/13/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        entryController.fetchEntries { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                        print(self.entryController.entries)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryTableViewCell else { return UITableViewCell() }
        let entry = entryController.entries[indexPath.row]
        cell.entry = entry
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = entryController.entries[indexPath.row]
            guard let index = entryController.entries.index(of: entry) else { return }
            entryController.entries.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewEntry" {
            guard let destinationVC = segue.destination as? EntryDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let entry = entryController.entries[indexPath.row]
            destinationVC.entry = entry
            print(entryController.entries[indexPath.row])
            destinationVC.entryController = entryController
        }
        else if segue.identifier == "AddEntry" {
            guard let destinationVC = segue.destination as? EntryDetailViewController else { return }
            destinationVC.entryController = entryController
        }
    }
    
    let entryController = EntryController()


}
