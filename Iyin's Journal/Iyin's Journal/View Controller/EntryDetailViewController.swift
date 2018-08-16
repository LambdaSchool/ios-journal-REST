//
//  EntryDetailViewController.swift
//  Iyin's Journal
//
//  Created by Iyin Raphael on 8/16/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    func updateViews(){
        if !isViewLoaded { return }
        
        switch entry {
        case nil:
            self.title = "Create Entry"
        default:
            self.title = entry?.title
            textField.text = entry?.title
            entryTextView.text = entry?.bodytext
        }
        
        
    }
 
    
    var entryController: EntryController?
    var entry: Entry?
  
    @IBAction func Send(_ sender: Any) {
        guard let title = textField.text,
            let bodyText = entryTextView.text else {return}
        
        if title == "" || bodyText == "" {return}
        
        if let entry = entry {
            entryController?.updateEntry(entry: entry, title: title, bodyText: bodyText) {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                
                return nil }
        } else {
            entryController?.createEntry(title: title, bodyText: bodyText){
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                
                return nil}
        }
    }
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var entryTextView: UITextView!
}
