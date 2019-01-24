//
//  EntryController.swift
//  Journal Project
//
//  Created by Michael Flowers on 1/24/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class EntryController {
    
    var entries: [Entry] = []
    private let baseURL = URL(string: "https://journal-4f354.firebaseio.com/")!
    
    func createEntry(with title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        
        //initialize a new entry then pass it to the put function
        let newEntry = Entry(title: title, bodyText: bodyText)
        
        //Where the put method requires a completion closure parameter, put the completion of "createEntry's" in the argument. This will essentially forward the completion clouse to the put method to the caller of createEntry so the potential error can be handled there.
        put(an: newEntry, completion: completion)
    }
    
    func put(an entry: Entry, completion: @escaping (Error?)-> Void) {
        
        let url = baseURL.appendingPathComponent(entry.identifier).appendingPathExtension("json")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        //encode our data and put your data into the body of the httpRequest
        //try to encode the data and assign it to the body of the httpbody request
        do {
            let jE = JSONEncoder()
           urlRequest.httpBody = try jE.encode(entry) //this entry is from the function
        } catch  {
            print("Error encoding model object into data: \(error)")
            completion(error)
            return
        }
        
        //now that we've turned our model object into data, and put that data into the request.httpbody, we can call the urlSession
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in //we are not getting data back so we can ignore it
            if let error = error {
                print("Error sending the data to the server: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func update(entry: Entry, newTitle: String, newBodyText: String, completion: @escaping (Error?)->Void){
        
        //implement this method like you would any other Update CRUD functions. At the end of the method though, in order to persist the change to the API, call the put method. Again, pass in the newly update entry (local variable inside the function) and pass in the Update functions's completion handler as an argument for the put function's.
        entry.title = newTitle
        entry.bodyText = newBodyText
    }
}
