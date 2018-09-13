//
//  EntryDetailViewController.swift
//  JournalREST
//
//  Created by Daniela Parra on 9/13/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    private func updateViews() {
        
        if isViewLoaded {
            guard let entry = entry else {
                title = "Create an entry"
                return
            }
            
            titleTextField.text = entry.title
            bodyTextView.text = entry.bodyText
        }
        
    }
    
    
    @IBAction func saveEntry(_ sender: Any) {
        guard let title = titleTextField.text,
            let bodyText = bodyTextView.text else { return }
        
        if let entry = entry {
            entryController?.updateEntry(entry: entry, title: title, bodyText: bodyText, completion: { (_) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
            return
        } else {
            entryController?.createEntry(title: title, bodyText: bodyText, completion: { (_) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
        
    }
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    var entryController: EntryController?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!

}
