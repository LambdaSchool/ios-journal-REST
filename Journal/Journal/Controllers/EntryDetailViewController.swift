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
        guard let title = textField.text else { return }
        guard let bodyText = textView.text else { return }
        guard let entry = self.entry else { return }
        
        entryController?.createEntry(title: title, bodyText: bodyText, completion: { (error) in
            if let error = error {
                print(error)
                return
            }
        entryController?.updateEntry(entry: Entry, title: String, bodyText: String, completion: { (error) in
            guard let index = entries.index(of: entry) else { return }
            return
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
