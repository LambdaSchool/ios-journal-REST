//  Copyright © 2019 Frulwinn. All rights reserved.

import Foundation

let baseURL = URL(string: "https://books-118d9.firebaseio.com/")!

class EntryController {
    var entries: [Entry] = []
    
    func put(entry: String, completion: @escaping(Error?) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText, timestamp: Date, identifier: identifier)
        let url = baseURL.appendingPathComponent(entry.identifier)
        let newURL = url.appendingPathExtension("json")
        
        var request = URLRequest(url: newURL)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(entry)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            self.entries.append(entry)
            completion(nil)
        }.resume()
    }
    
}
