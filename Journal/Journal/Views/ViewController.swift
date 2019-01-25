//
//  ViewController.swift
//  Journal
//
//  Created by Angel Buenrostro on 1/24/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let entryController = EntryController()
        entryController.createEntry(title: "testEntry1", bodyText: "testEntry1Text") { (error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                print("Number of entries: \(entryController.entries.count)")
            }
        }
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

}
