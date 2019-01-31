//
//  EntriesTableViewController.swift
//  Journal Project
//
//  Created by Michael Flowers on 1/24/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    let entryController = EntryController()

    override func viewDidLoad() {
        super.viewDidLoad()
        entryController.createEntry(with: "hahahahah", bodyText: "99292929229") { (error) in
            if let error = error {
                print("Errormaking mock data:\(error.localizedDescription)")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        entryController.fetchEntries { (error) in
            if let error = error {
                print("Error in the view will appear in the entries tableViewController :\(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EntryTableViewCell
        let entry = entryController.entries[indexPath.row]
        //pass an Entry to the cell's "entry" property in order for it to call the updateViews() method to fill in the information for the cell's labels.
        cell.entry = entry
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "cellSegue" {
            guard let toDestinationVC = segue.destination as? EntryDetailViewController, let index = tableView.indexPathForSelectedRow else { return }
            let entryToPass = entryController.entries[index.row]
            toDestinationVC.entryController = entryController
            toDestinationVC.entry = entryToPass
            
        } else if segue.identifier == "addButton"{
            guard let toDestinationVC = segue.destination as? EntryDetailViewController else { return }
            toDestinationVC.entryController = entryController
        }
    }
 

}
