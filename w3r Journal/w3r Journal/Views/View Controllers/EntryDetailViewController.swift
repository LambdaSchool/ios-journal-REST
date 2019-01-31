//
//  EntryDetailViewController.swift
//  w3r Journal
//
//  Created by Michael Flowers on 1/31/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    var ec: EntryController?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveEntry(_ sender: UIBarButtonItem) {
        guard let title = textField.text, !title.isEmpty, let bodyText = textView.text, !bodyText.isEmpty else {return}
        guard let passedInEntry = entry else {
            ec?.createEntry(with: title, bodyText: bodyText , completion: { (error) in
                if let error = error {
                    print("Error creating entry: \(error.localizedDescription)")
                }
                
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            })
            
            return
        }
        print("passediNEntry update: \(passedInEntry)")
        ec?.updateEntry(with: passedInEntry, newTitle: title, newBodyText: bodyText, completion: { (error) in
            if let error = error {
                print("Error creating entry: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
        
    }
    
    func updateViews(){
        if isViewLoaded {
         
            guard let passedInEntry = entry else {
                navigationController?.title = "Create Entry"
                return}
            print(passedInEntry)
            textField.text = passedInEntry.title
            textView.text = passedInEntry.bodyText
            navigationController?.title = passedInEntry.title
        }
    }
    
}
