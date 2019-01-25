//
//  EntryDetailViewController.swift
//  Journal Project
//
//  Created by Michael Flowers on 1/24/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entryController: EntryController?
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty, let body = bodyText.text, !body.isEmpty else { return }
        
        guard let passedInEntry = entry else {
            //there was no entry so we want to create
            entryController?.createEntry(with: title, bodyText: body, completion: { (error) in
                if let error = error {
                    print("We could not create the entry in the detailViewController: \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
            return
        }
        
        //there was an entry so we want to update
        entryController?.update(entry: passedInEntry, newTitle: title, newBodyText: body, completion: { (error) in
            if let error = error {
                print("We could not update the entry: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    func updateViews(){
        guard let passedInEntry = entry else {
            title = "Create Entry"
            return }
        if viewIfLoaded != nil {
        titleTextField.text = passedInEntry.title
        bodyText.text = passedInEntry.bodyText
        title = passedInEntry.title
        }
    }
}
