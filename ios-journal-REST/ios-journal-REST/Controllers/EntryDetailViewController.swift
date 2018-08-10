//
//  EntryDetailViewController.swift
//  ios-journal-REST
//
//  Created by Lambda-School-Loaner-11 on 8/9/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entry: Entry?
    
    var entryController: EntryController?
    
    var entriesTableViewController: EntriesTableViewController?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func saveButton(_ sender: Any) {
        
        guard let title = textField.text, let bodyText = textView.text else { return }
        
        if let entry = entry {
            entryController?.updateEntry(entry: entry, title: title, bodyText: bodyText, completion: { (error) in
                self.entriesTableViewController?.fetchData()
            })
        } else {
            entryController?.createEntry(title: title, bodyText: bodyText, completion: { (error) in
                self.entriesTableViewController?.fetchData()
            })
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let entry = entry else { return }
        
        self.textField.text = entry.title
        self.textView.text = entry.bodyText
    }
}
