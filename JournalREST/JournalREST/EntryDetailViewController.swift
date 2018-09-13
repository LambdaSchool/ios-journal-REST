//
//  EntryDetailViewController.swift
//  JournalREST
//
//  Created by Daniela Parra on 9/13/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    
    @IBAction func saveEntry(_ sender: Any) {
    }
    
    var entry: Entry?
    var entryController: EntryController?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!

}
