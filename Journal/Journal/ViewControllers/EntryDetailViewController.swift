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
        let bodyText = storyTextView.text else {return}
        if let entry = self.entry
        {
            entryController?.updateEntry(entry: entry, title: title, bodyText: bodyText, completion: { (error) in
                if let error = error
                {
                    NSLog("There was an error while trying to update, Swift says: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
        else
        {
            entryController?.createEntry(title: title, bodyText: bodyText, completion: { (error) in
                if let error = error
                {
                    NSLog("problem \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
