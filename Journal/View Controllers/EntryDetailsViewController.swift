//
//  EntryDetailsViewController.swift
//  Journal
//
//  Created by Jason Modisett on 9/13/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

class EntryDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let entry = entry else { return }
        
        title = entry.title
        
        titleTextField.text = entry.title
        entryTextView.text = entry.bodyText
    }

    
    @IBAction func saveEntry(_ sender: Any) {
        guard let entryController = entryController,
            let titleText = titleTextField.text,
            let bodyText = entryTextView.text else { return }
        
        guard let entry = entry else {
            entryController.createEntry(with: titleText, bodyText: bodyText) { (error) -> (Void) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            return
        }
        
        entryController.update(entry: entry, title: titleText, bodyText: bodyText) { (error) -> (Void) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    var entry: Entry?
    var entryController: EntryController?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var entryTextView: UITextView!
    
}
