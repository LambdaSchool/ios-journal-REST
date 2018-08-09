//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Linh Bouniol on 8/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    var entryController: EntryController?
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var textView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        guard let title = titleTextField.text, let text = textView.text else { return }
        
        if let entry = entry {
            entryController?.update(entry: entry, title: title, bodyText: text, completion: { (error) in
                if let error = error {
                    NSLog("Error occured while updating the entry: \(error)")
                }
                
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            entryController?.createEntry(withTitle: title, bodyText: text, completion: { (error) in
                if let error = error {
                    NSLog("Error occured while creating the entry: \(error)")
                }
                
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    func updateViews() {
        guard isViewLoaded else { return }
        
        if let entry = entry {
            navigationItem.title = entry.title
            titleTextField.text = entry.title
            textView.text = entry.bodyText
        } else {
            navigationItem.title = "Create Entry"
        }
    }

}
