//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Carolyn Lea on 8/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell
{
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var storyLabel: UILabel!
    
    // MARK: - Properties
    
    var entry: Entry?
    {
        didSet
        {
            updateViews()
        }
    }
    
    
    // MARK: - Functions
    
    func getReadableDate(timeStamp: TimeInterval) -> String? {
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    func updateViews()
    {
        guard let entry = entry else {return}
        
        let currentDate = entry.timeStamp
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: currentDate)
        print(dateString)
        
        titleLabel.text = entry.title
        dateLabel.text = dateString
        storyLabel.text = entry.bodyText
    }
    
}
