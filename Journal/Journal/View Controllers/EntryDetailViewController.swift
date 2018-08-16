//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Lisa Sampson on 8/16/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        
        if let entry = entry {
            navigationItem.title = entry.title
            entryTitleTextField.text = entry.title
            bodyTextView.text = entry.bodyText
        } else {
            navigationItem.title = "Create Entry"
        }
    }
    
    @IBAction func saveEntryButtonTapped(_ sender: Any) {
        guard let title = entryTitleTextField.text,
            let bodyText = bodyTextView.text else { return }
        
        if let entry = entry {
            entryController?.update(entry: entry, title: title, bodyText: bodyText, completion: { (success) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            entryController?.createEntry(title: title, bodyText: bodyText, completion: { (success) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    var entryController: EntryController?
    
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
}
