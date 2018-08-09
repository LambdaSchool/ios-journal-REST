
import Foundation
import UIKit

typealias ErrorString = String
typealias CompletionHandler = (ErrorString?)->Void

enum App
{
	static let baseURL = URL(string:"https://pushier-and-postier.firebaseio.com/")!
	static var controller = JournalController()
}

func buildRequest(_ ids:[String], _ httpMethod:String, _ data:Data?=nil) -> URLRequest
{
	var url = App.baseURL
	for id in ids {
		url.appendPathComponent(id)
	}
	url.appendPathExtension("json")
	var req = URLRequest(url: url)
	req.httpMethod = httpMethod
	req.httpBody = data
	return req
}

