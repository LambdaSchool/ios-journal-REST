//
//  EntryDetailViewController.swift
//  JournalREST
//
//  Created by Ilgar Ilyasov on 9/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var entryController: EntryController?
    var entry: Entry? {
        didSet { updateViews() }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    // MARK: - Application lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    // MARK: - Actions
    
    @IBAction func saveBarButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text,
            let body = bodyTextView.text else { return }
        
        // If entry is not nil
        if let entry = entry {
            entryController?.updateEntry(entry: entry, title: title, bodyText: body, completion: { (_) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            entryController?.createEntry(title: title, bodyText: body, completion: { (_) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
        
    }
    
    // MARK: - Update view
    
    private func updateViews() {
        
        if isViewLoaded {
            
            // If entry is not nil then set views values
            if let entry = entry {
                title = entry.title
                titleTextField.text = entry.title
                bodyTextView.text = entry.bodyText
            }
            // If it's nil
            else {
                title = "Create Entry"
            }
        }
    }
    
}
