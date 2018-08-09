
import Foundation
import UIKit

class JournalController
{
	var entries:[JournalEntry] = []

	func create(_ t:String, _ c:String)
	{
		entries.append(JournalEntry(t, c))
	}

	func addUpdate(_ e:JournalEntry)
	{
		if let i = entries.index(of:e) {
			entries[i] = e
		} else {
			entries.append(e)
		}
	}

	func push(_ e:JournalEntry, _ completion: @escaping CompletionHandler)
	{
		var data:Data?
		do {
			data = try JSONEncoder().encode(e)
		} catch {
			NSLog("Error pushing: could not encode json")
			completion("Error pushing: could not encode json")
			return
		}

		let req = buildRequest([e.identifier], "PUT", data)
		URLSession.shared.dataTask(with: req) {
			(data, _, error) in
			if let error = error {
				NSLog("Error pushing data: \(error)")
				completion("Error pushing data")
				return
			}
			completion(nil)
			}.resume()
	}

	func pushAll(_ completion: @escaping CompletionHandler)
	{
		var data:Data?
		do {
			var entryDict:[String:JournalEntry] = [:]
			for e in entries {
				entryDict[e.identifier] = e
			}

			data = try JSONEncoder().encode(entryDict)
		} catch {
			NSLog("Error pushing: could not encode json")
			completion("Error pushing: could not encode json")
			return
		}

		let req = buildRequest([], "PUT", data)
		URLSession.shared.dataTask(with: req) {
			(data, _, error) in
			if let error = error {
				NSLog("Error pushing data: \(error)")
				completion("Error pushing data")
				return
			}
			completion(nil)
		}.resume()
	}

	func fetch(_ completion: @escaping CompletionHandler)
	{
		let req = buildRequest([], "GET")
		URLSession.shared.dataTask(with: req) {
			(data, _, error) in
			if let error = error {
				NSLog("Error fetching data: \(error)")
				completion("Error fetching data")
				return
			}

			guard let data = data else {
				NSLog("Error fetching: data was nil!")
				completion("Error fetching: data was nil!")
				return
			}

			do {
				let json = try JSONDecoder().decode([String:JournalEntry].self, from: data)
				self.entries = Array(json.values)
				completion(nil)
			} catch {
				NSLog("Error fetching: could not decode json")
				completion("Error fetching: could not decode json")
				return
			}
		}.resume()
	}

	func delete(_ e:JournalEntry, _ completion: @escaping CompletionHandler)
	{
		guard let index = entries.index(of:e) else {return}
		entries.remove(at: index)
		let req = buildRequest([e.identifier], "DELETE")
		URLSession.shared.dataTask(with: req) { (data, _, error) in
			if let error = error {
				NSLog("Error deleting: \(error)")
				completion("Error deleting")
				return
			}
			completion(nil)
		}.resume()
	}
}
