//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Jocelyn Stuart on 1/24/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    var entryController: EntryController?
    
    
    func updateViews() {
        
        if let entry = entry, isViewLoaded {
            titleTextField.text = entry.title
            entryBodyTextView.text = entry.bodyText
            
            navigationItem.title = titleTextField.text
            
        } else {
            navigationItem.title = "Create Entry"
        }
        
    }

    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBOutlet weak var entryBodyTextView: UITextView!
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, let entryBody = entryBodyTextView.text else { return }
        
        if let entry = entry {
            entryController?.update(withEntry: entry, andTitle: title, andBody: entryBody, completion: { (error) in
                if let error = error {
                    print(error)
                }
                DispatchQueue.main.async {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            })
            
        } else {
            entryController?.createEntry(withTitle: title, andBody: entryBody, completion: { (error) in
                if let error = error {
                    print(error)
                }
                DispatchQueue.main.async {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    
    
}
