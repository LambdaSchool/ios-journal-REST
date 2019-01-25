//  Copyright © 2019 Frulwinn. All rights reserved.

import Foundation

let baseURL = URL(string: "https://books-118d9.firebaseio.com/")!

class EntryController {
    var entries: [Entry] = []
    
    func put(entry: Entry, completion: @escaping(Error?) -> Void) {

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
    
    func createEntry(title: String, bodyText: String, completion: @escaping(Error?) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText)
        put(entry: entry, completion: completion)
        
    }
    
    func updateEntry(entry: Entry, title: String, bodyText: String, completion: @escaping(Error?) -> Void) {
        guard let index = entries.index(of: entry) else { return }
        entries[index].title = title
        entries[index].bodyText = bodyText
        put(entry: entry, completion: completion)

    }
    
    func fetchEntries(completion: @escaping(Error?) -> Void) {
        let url = baseURL.appendingPathExtension("json")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let decodeDictionary = try jsonDecoder.decode([String: Entry].self, from: data)
                let decodedEntries = Array(decodeDictionary.values)
                let sortedEntries = decodedEntries.sorted(by: { ($0.timestamp) > ($1.timestamp) } )
                self.entries = sortedEntries
                completion(nil)
            } catch {
                print("Error decoding received data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
//    func delete(at indexPath: IndexPath, completion: @escaping () -> Void ) {
//        let entry = entries[indexPath.row]
//        entries.delete(entry: entry) { success in
//            guard succes else { return }
//        }
//    }
}
