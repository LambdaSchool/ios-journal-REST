//
//  EntryController.swift
//  Iyin's Journal
//
//  Created by Iyin Raphael on 8/16/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import Foundation

let baseURL: URL = URL(fileURLWithPath: "https://iyin-s-journal.firebaseio.com/")

class EntryController {
    
    var entries: [Entry] = []
    
    
    
    func put(entry: Entry, completion: @escaping  () ->Error?){
        
        //Create a URL that appends the Entry parameter's identifier to create a unique Url for this ENtry to be stored on the API
        //Also append the JSON path extention at the of URL
        let url = baseURL.appendingPathComponent(entry.identifier).appendingPathExtension("json")
        
        //create a request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do{
            let jsonEncoder  = JSONEncoder()
            request.httpBody = try jsonEncoder.encode(entry)
            
        }catch{
            NSLog("Error when encoding")
            return
        }
        URLSession.shared.dataTask(with: request) { ( _, _, error) in
            if let error = error {
                NSLog("Error posting new device: \(error)")
                return
            }
        }.resume()
        
    }
    
    
    
    //MARK: CRUD
    
    //CREATE
    
    func createEntry(title: String, bodyText: String, completion: @escaping ()-> Error?) {
        let entry = Entry(title: title, bodytext: bodyText)
        entries.append(entry)
        put(entry: entry) { () -> Error? in
            completion()
        }
    
    
    }
    //UPDATE
    
    
    func updateEntry(entry: Entry, title: String, bodyText: String, completion: @escaping () -> Error? ){
        guard let index = entries.index(of: entry) else {return}
        entries[index].title = title
        entries[index].bodytext = bodyText
        
        put(entry: entries[index]) { () -> Error? in
            completion()
        }
    }
    
    //Delete Entry ONLY locally.
    func delete(entry: Entry){
        guard let index = entries.index(of:entry) else { return}
        entries.remove(at: index)
    }
    
    
    func fetchEntries(completion: @escaping (Error?) -> Void){
        let url = baseURL.appendingPathExtension("json")
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog( "Error fetching: \(error)")
                return
            }
            
            guard let data = data else {return}
            let decoder = JSONDecoder()
            
            do{
                let decodedDict = try decoder.decode([String: Entry].self, from: data)
                let decodedEntries = Array(decodedDict.values)
                self.entries = decodedEntries.sorted{ return $0.timestamp < $1.timestamp }
                completion(nil)
            } catch {
                NSLog("Error decoding: \(error)")
            }
            
            }.resume()
        
    }
    
    func deleteEntry(entry: Entry, completion: @escaping (Error?) ->Void){
        let url = baseURL
            .appendingPathComponent(entry.identifier)
            .appendingPathExtension("json")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error deleting: \(error)")
                return
            }
            self.delete(entry: entry)
            completion(nil)
            }.resume()
    }
}
