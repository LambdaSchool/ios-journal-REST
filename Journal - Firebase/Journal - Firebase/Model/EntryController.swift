import Foundation

class EntryController {
    
    // Data Source
    var entries: [Entry] = []
    
    // Firebase URL
    let baseURL = URL(string: "https://lambdajournalentry.firebaseio.com/")!

    func put(entry: Entry, completion: @escaping (Error?) -> Void) {
        let entryIdentifierURL = baseURL.appendingPathComponent(entry.identifier)
        let withJSONURL = entryIdentifierURL.appendingPathExtension("json")
        
        var requestURL = URLRequest(url: withJSONURL)
        requestURL.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            requestURL.httpBody = try encoder.encode(entry)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (_, _, error) in
            
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            completion(nil)
            
        }.resume()

    }
    
}
