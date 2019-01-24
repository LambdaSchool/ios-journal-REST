//
//  ViewController.swift
//  FirebaseJournalAPP
//
//  Created by Nelson Gonzalez on 1/24/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entryController: EntryController?
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
  

    override func viewDidLoad() {
        super.viewDidLoad()
            updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
            guard let entry = entry else {
                title = "Create Entry"
                
                return
            }
            title = entry.title
            titleTextField.text = entry.title
            bodyTextView.text = entry.bodyText
        }
    }

    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let titleText = titleTextField.text, !titleText.isEmpty, let bodyText = bodyTextView.text, !bodyText.isEmpty else {return}
        
        if let entry = entry {
            entryController?.update(entry: entry, title: titleText, bodyText: bodyText, completion: { (error) in
                if error != nil {
                    print("Error updating journal in entry detail VC \(error!.localizedDescription)")
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            entryController?.createEntry(with: titleText, bodyText: bodyText, completion: { (error) in
                if error != nil {
                    print("Error creating entry in entry detail VC \(error!.localizedDescription)")
                }
                
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
            
        }
    }
    
}

