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

        
    }
    
    @IBAction func saveEntryButtonTapped(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var entry: Entry?
    var entryController: EntryController?
    
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
}
