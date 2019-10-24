//
//  AuthService.swift
//  Smack
//
//  Created by Trinh Thai on 10/1/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
        
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping completionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let url: String = URL_REGISTER
        
        let HTTPMethod: HTTPMethod = .post
        
        let header = HEADER
        
        let body: [String: Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        Alamofire.request(url, method: HTTPMethod, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping completionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            /// C1: json = response.result.value
//            if response.result.error == nil {
//                if let json = response.result.value as? Dictionary<String, Any> {
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//                    self.isLoggedIn = true
//                    completion(true)
//                } else {
//                    completion(false)
//                    debugPrint(response.result.error as Any)
//                }
//            } else {
//                completion(false)
//            }
            
            /// C2: data = response.data
//            if response.result.error == nil {
//                if let data = response.data{
//                    if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>, let email = json["user"] as? String, let token = json["token"] as? String{
//                        self.userEmail = email
//                        self.authToken = token
//                    }
//                }
//                self.isLoggedIn = true
//                completion(true)
//            } else {
//                completion(false)
//            }
            
            /// C3: Use SwiftyJSON
            if response.result.error == nil {
                if let data = response.data {
                    do {
                        let json = try JSON(data:data)
                        self.userEmail = json["user"].stringValue
                        self.authToken = json["token"].stringValue
                    } catch {
                        print(error)
                    }
                }
                self.isLoggedIn = true
                completion(true)

            } else {
                completion(false)
            }
            
            ///C4: Codable
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping completionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body = [
            "name" : name,
            "email" : lowerCaseEmail,
            "avatarName" : avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {
                    completion(false)
                    return
                }
                do {
                    let json = try JSON(data: data)
                    self.setUserData(json: json)
                    completion(true)
                } catch {
                    print(error)
                    completion(false)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    func findUserByEmail(completion: @escaping completionHandler) {
        Alamofire.request("\(URL_FIND_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {
                    completion(false)
                    return
                }
                do {
                    let json = try JSON(data: data)
                    self.setUserData(json: json)
                    completion(true)
                } catch {
                    print(error)
                    completion(false)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func setUserData(json: JSON) {
        let id = json["_id"].stringValue
        let color = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json ["name"].stringValue
        
        UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
    }
    
}
