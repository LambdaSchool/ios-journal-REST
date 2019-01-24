//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Nathanael Youngren on 1/24/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    // Properties
    
    var entry: Entry?
    var entryController: EntryController?
    
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var entryTextView: UITextView!
  
}
