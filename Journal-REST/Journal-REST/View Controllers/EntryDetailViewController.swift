//
//  EntryDetailViewController.swift
//  Journal-REST
//
//  Created by Moses Robinson on 1/24/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
            let bodyText = bodyTextView.text, !bodyText.isEmpty else { return }
        
        if let entry = entry {
            entryController?.update(entry: entry, title: title, bodyText: bodyText, completion: { (error) in
                if let error = error {
                    NSLog("Could not update entry: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            entryController?.createEntry(title: title, bodyText: bodyText, completion: { (error) in
                if let error = error {
                    NSLog("Could not create entry: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
        
    }
    
    private func updateViews() {
        if isViewLoaded {
            
            title = "Create Entry"
            
            guard let entry = entry else { return }
            
            title = entry.title
            titleTextField.text = entry.title
            bodyTextView.text = entry.bodyText
        }
    }
    
    // MARK: - Properties
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    var entryController: EntryController?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
}
