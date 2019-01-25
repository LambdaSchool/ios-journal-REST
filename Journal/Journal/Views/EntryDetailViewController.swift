//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Angel Buenrostro on 1/24/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entry: Entry? {
        didSet{
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    var entryController: EntryController?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let title = textField.text else { return }
        guard let text  = textView.text else { return }
        
        guard let entry = entry else {
            entryController?.createEntry(title: title, bodyText: text, completion: { (error) in
                if let error = error {
                    print(error)
                }
                self.navigationController?.popViewController(animated: true)
            })
            return
        }
        entryController?.update(entry: entry, title: title, bodyText: text, completion: { (error) in
            if let error = error {
                print(error)
                return
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.updateViews()
        }
        // Do any additional setup after loading the view.
    }
    
    
    func updateViews(){
        if entry != nil {
            self.title = entry!.title
            textField.text = entry?.title
            textView.text = entry?.bodyText
        } else {
          self.title = "Create Entry"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
