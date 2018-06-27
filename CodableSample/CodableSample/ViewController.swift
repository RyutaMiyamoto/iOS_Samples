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
        private let _login: String?
        private let _id: Int?
        private let _nodeId: String?
        private let _avatarUrl: String?
        private let _gravatarId: String?
        private let _url: String?
        private let _htmlUrl: String?
        private let _followersUrl: String?
        private let _followingUrl: String?
        private let _gistsUrl: String?
        private let _starredUrl: String?
        private let _subscriptionsUrl: String?
        private let _organizationsUrl: String?
        private let _reposUrl: String?
        private let _eventsUrl: String?
        private let _receivedEventsUrl: String?
        private let _type: String?
        private let _siteAdmin: Bool?
        
        var login: String {
            return _login ?? ""
        }
        var id: Int {
            return _id ?? 0
        }
        var nodeId: String {
            return _nodeId ?? ""
        }
        var avatarUrl: String {
            return _avatarUrl ?? ""
        }
        var gravatarId: String {
            return _gravatarId ?? ""
        }
        var url: String {
            return _url ?? ""
        }
        var htmlUrl: String {
            return _htmlUrl ?? ""
        }
        var followersUrl: String {
            return _followersUrl ?? ""
        }
        var followingUrl: String {
            return _followingUrl ?? ""
        }
        var gistsUrl: String {
            return _gistsUrl ?? ""
        }
        var starredUrl: String {
            return _starredUrl ?? ""
        }
        var subscriptionsUrl: String {
            return _subscriptionsUrl ?? ""
        }
        var organizationsUrl: String {
            return _organizationsUrl ?? ""
        }
        var reposUrl: String {
            return _reposUrl ?? ""
        }
        var eventsUrl: String {
            return _eventsUrl ?? ""
        }
        var receivedEventsUrl: String {
            return _receivedEventsUrl ?? ""
        }
        var type: String {
            return _type ?? ""
        }
        var siteAdmin: Bool {
            return _siteAdmin ?? false
        }
        
        enum CodingKeys: String, CodingKey {
            case _login = "login"
            case _id = "id"
            case _nodeId = "node_id"
            case _avatarUrl = "avatar_url"
            case _gravatarId = "gravatar_id"
            case _url = "url"
            case _htmlUrl = "html_url"
            case _followersUrl = "followers_url"
            case _followingUrl = "following_url"
            case _gistsUrl = "gists_url"
            case _starredUrl = "starred_url"
            case _subscriptionsUrl = "subscriptions_url"
            case _organizationsUrl = "organizations_url"
            case _reposUrl = "repos_url"
            case _eventsUrl = "events_url"
            case _receivedEventsUrl = "received_events_url"
            case _type = "type"
            case _siteAdmin = "site_admin"
        }
    }
    
    @IBAction func tapGetJsonButton(_ sender: UIButton) {
        let requestController = MyRequestController()
        requestController.sendRequest({ data in
            guard let data = data else { return }
            let decoder: JSONDecoder = JSONDecoder()
            do {
                let users: [User] = try decoder.decode([User].self, from: data)
                for user in users {
                    print(user.login)
                    print(user.id)
                    print(user.nodeId)
                }
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
