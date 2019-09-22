//
//  ViewController.swift
//  CodableSample
//
//  Created by R.miyamoto on 2019/09/16.
//  Copyright © 2019 R.Miyamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct User: Codable {
        
        let login: String
        let id: Int
        let nodeId: String
        let avatarUrl: String
        let gravatarId: String
        let url: String
        let htmlUrl: String
        let followersUrl: String
        let followingUrl: String
        let gistsUrl: String
        let starredUrl: String
        let subscriptionsUrl: String
        let organizationsUrl: String
        let reposUrl: String
        let eventsUrl: String
        let receivedEventsUrl: String
        let type: String
        let siteAdmin: Bool
        
        enum CodingKeys: String, CodingKey {
            case login
            case id
            case nodeId = "node_id"
            case avatarUrl = "avatar_url"
            case gravatarId = "gravatar_id"
            case url
            case htmlUrl = "html_url"
            case followersUrl = "followers_url"
            case followingUrl = "following_url"
            case gistsUrl = "gists_url"
            case starredUrl = "starred_url"
            case subscriptionsUrl = "subscriptions_url"
            case organizationsUrl = "organizations_url"
            case reposUrl = "repos_url"
            case eventsUrl = "events_url"
            case receivedEventsUrl = "received_events_url"
            case type
            case siteAdmin = "site_admin"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            login = container.decode(forKey: CodingKeys.login, defaultValue: "")
            id = container.decode(forKey: CodingKeys.id, defaultValue: 0)
            nodeId = container.decode(forKey: CodingKeys.nodeId, defaultValue: "")
            avatarUrl = container.decode(forKey: CodingKeys.avatarUrl, defaultValue: "")
            gravatarId = container.decode(forKey: CodingKeys.gravatarId, defaultValue: "")
            url = container.decode(forKey: CodingKeys.url, defaultValue: "")
            htmlUrl = container.decode(forKey: CodingKeys.htmlUrl, defaultValue: "")
            followersUrl = container.decode(forKey: CodingKeys.followersUrl, defaultValue: "")
            followingUrl = container.decode(forKey: CodingKeys.followingUrl, defaultValue: "")
            gistsUrl = container.decode(forKey: CodingKeys.gistsUrl, defaultValue: "")
            starredUrl = container.decode(forKey: CodingKeys.starredUrl, defaultValue: "")
            subscriptionsUrl = container.decode(forKey: CodingKeys.subscriptionsUrl, defaultValue: "")
            organizationsUrl = container.decode(forKey: CodingKeys.organizationsUrl, defaultValue: "")
            reposUrl = container.decode(forKey: CodingKeys.reposUrl, defaultValue: "")
            eventsUrl = container.decode(forKey: CodingKeys.eventsUrl, defaultValue: "")
            receivedEventsUrl = container.decode(forKey: CodingKeys.receivedEventsUrl, defaultValue: "")
            type = container.decode(forKey: CodingKeys.type, defaultValue: "")
            siteAdmin = container.decode(forKey: CodingKeys.siteAdmin, defaultValue: false)
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

extension KeyedDecodingContainer {
    func decode<ResultType: Decodable>(forKey key: Key, defaultValue: ResultType) -> ResultType {
        return (try? decode(ResultType.self, forKey: key)) ?? defaultValue
    }
}


