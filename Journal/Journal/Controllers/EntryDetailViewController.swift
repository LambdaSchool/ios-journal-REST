//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class EntryDetailViewController: UIViewController {

    //MARK: Properties
    var entry: Entry? {
        didSet {
            updateViews()
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
        guard isViewLoaded else { return }
        guard let entry = entry else {
            title = "Create Entry"
            return
        }
        navigationItem.title = entry.title
        textField.text = entry.title
        textView.text = entry.bodyText
    }
}
