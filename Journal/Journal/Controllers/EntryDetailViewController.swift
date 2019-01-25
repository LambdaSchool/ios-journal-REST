//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class EntryDetailViewController: UIViewController {

    //MARK: Properties
    var entry: Entry? {
        didSet {
            updateView()
        }
    }
    var entryController: EntryController?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBAction func save(_ sender: Any) {
        guard let title = textField.text, !title.isEmpty,
        let bodyText = textView.text else { return }
        
        if let entry = entry {
            entryController?.updateEntry(entry: entry, title: title, bodyText: bodyText, completion: { (_) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
        } else {
        entryController?.createEntry(title: title, bodyText: bodyText, completion: { (_) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
       
    }
    
    func updateViews() {
        if isViewLoaded {
            navigationItem.title = entry?.title
        } else {
            navigationItem.title = "CreateEntry"
    
        }
    }
}
