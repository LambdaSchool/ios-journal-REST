//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Carolyn Lea on 8/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var storyTextView: UITextView!
    
    // MARK: - Properties
    
    var entry: Entry?
    var entryController: EntryController?
    
    // MARK: - View Setup
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    
    // MARK: - Button Actions
    
    @IBAction func save(_ sender: Any)
    {
        guard let title = titleTextField.text,
            let bodyText = storyTextView.text,
        let entry = self.entry
            else {return}
        
        entryController?.createEntry(title: title, bodyText: bodyText, timeStamp: entry.timeStamp, identifier: entry.identifier, completion: { (error) in
            if let error = error
            {
                NSLog("problem \(error)")
                return
                
            }
        })
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
