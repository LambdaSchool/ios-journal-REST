
import Foundation
import UIKit

struct JournalEntry: Codable, Equatable
{
	var title:String
	var content:String
	var identifier:String
	var timestamp:Date

	init(_ t:String, _ c:String)
	{
		title = t
		content = c
		identifier = UUID().uuidString
		timestamp = Date()
	}

	static func ==(l:JournalEntry, r:JournalEntry) -> Bool
	{
		return l.identifier == r.identifier
	}
}
