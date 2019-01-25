//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Angel Buenrostro on 1/24/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    let entryController = EntryController()
    
    override func viewWillAppear(_ animated: Bool) {
        entryController.fetchEntries { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(self.entryController.entries)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return entryController.entries.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entrycell", for: indexPath) as! EntryTableViewCell
        let entry = entryController.entries[indexPath.row]
        cell.entry = entry

        return cell
    }
  

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DispatchQueue.main.async {
                self.entryController.entries.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                //TODO: Actually delete the cell from the API database not just the tableview
            }
        }
    }
   

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "plusSegue"{
            let detailVC = segue.destination as! EntryDetailViewController
            detailVC.entryController = entryController
        }
        if segue.identifier == "entrySegue"{
            let cell = sender as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let entry = entryController.entries[indexPath.row]
            let detailVC = segue.destination as! EntryDetailViewController
            detailVC.entryController = entryController
            detailVC.entry = entry 
        }
    }
    

}

