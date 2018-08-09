//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Jeremy Taylor on 8/9/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    var entryController: EntryController?
    
    private func updateViews() {
        guard isViewLoaded,
            let entry = entry else {
                title = "Create Entry"
                return
        }
        title = entry.title
        titleTextField.text = entry.title
        textView.text = entry.bodyText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let titleText = titleTextField.text,
            let bodyText = textView.text else { return }
        
        guard let entry = entry else {
            entryController?.createEntry(withTitle: titleText, andText: bodyText, completion: { (error) in
                if let error = error {
                    NSLog("Error creating entry: \(error)")
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
            
            
            return
        }
        
        entryController?.updateEntry(entry: entry, withTitle: titleText, andText: bodyText, completion: { (error) in
            if let error = error {
                NSLog("Can't update entry: \(error)")
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
