//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Linh Bouniol on 8/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var textView: UITextView!
    
    @IBAction func save(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
