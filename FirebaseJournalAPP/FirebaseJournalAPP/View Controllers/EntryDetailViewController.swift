//
//  ViewController.swift
//  FirebaseJournalAPP
//
//  Created by Nelson Gonzalez on 1/24/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        let entryController = EntryController()
//        entryController.createEntry(with: "Nelson", bodyText: "Testing Journal") { (error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            }
//            
//            print("SUCCESSFULLY ADDED DATA TO DATABASE")
//            
//        }
    }

    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
    }
    
}

