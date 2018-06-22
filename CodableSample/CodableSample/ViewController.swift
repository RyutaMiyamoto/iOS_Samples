//
//  ViewController.swift
//  CodableSample
//
//  Created by RyutaMiyamoto on 2018/06/22.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct User: Codable {
        let login: String
        let id: Int
        let node_id: String
        let avatar_url: String
        let gravatar_id: String
        let url: String
        let html_url: String
        let followers_url: String
        let following_url: String
        let gists_url: String
        let starred_url: String
        let subscriptions_url: String
        let organizations_url: String
        let repos_url: String
        let events_url: String
        let received_events_url: String
        let type: String
        let site_admin: Bool
    }
    
    @IBAction func tapGetJsonButton(_ sender: UIButton) {
        let requestController = MyRequestController()
        requestController.sendRequest({ data in
            let decoder: JSONDecoder = JSONDecoder()
            do {
                let json: [User] = try decoder.decode([User].self, from: data!)
                print(json)
            } catch {
                print("error:", error.localizedDescription)
            }
        })
    }
}

// MARK: - Auxiliary Class

class MyRequestController {
    func sendRequest(_ completion: @escaping (Data?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        guard var URL = URL(string: "https://api.github.com/users") else {return}
        let URLParams: Dictionary<String, String> = [:]
        URL = URL.appendingQueryParameters(URLParams)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                completion(data)
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}
