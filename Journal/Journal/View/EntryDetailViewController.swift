//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Dillon McElhinney on 9/13/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Properties
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    var entryController: EntryController?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    // MARK: - UI Methods
    @IBAction func saveEntry(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
            let bodyText = bodyTextView.text, !bodyText.isEmpty else { return }
        
        if let entry = entry {
            entryController?.update(entry, title: title, bodyText: bodyText, completion: { (_) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            entryController?.createEntry(title: title, bodyText: bodyText, completion: { (_) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    // MARK: - Utility Methods
    private func updateViews() {
        guard isViewLoaded else { return }
        guard let entry = entry else {
            title = "Create Entry"
            return
        }
        
        title = entry.title
        titleTextField.text = entry.title
        bodyTextView.text = entry.bodyText
    }
}
