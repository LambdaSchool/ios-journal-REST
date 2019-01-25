//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Nathanael Youngren on 1/24/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = entryTitleTextField.text,
            let body = entryTextView.text else { return }
        
        if let entry = entry {
            entryController?.update(entry: entry, title: title, bodyText: body, completion: { (error) in
                if let error = error {
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            entryController?.createEntry(title: title, bodyText: body, completion: { (error) in
                if let error = error {
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        if let entry = entry {
            navigationItem.title = entry.title
            entryTitleTextField?.text = entry.title
            entryTextView?.text = entry.bodyText
        } else {
            navigationItem.title = "Create Entry"
        }
    }
    
    // Properties
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    var entryController: EntryController?
    
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var entryTextView: UITextView!
  
}
