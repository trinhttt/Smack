//
//  MessageService.swift
//  Smack
//
//  Created by Trinh Thai on 10/24/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel: Channel?
    
    func findAllChanels(completion: @escaping completionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {
                    return
                }
                
                do {
                    let json = try JSON(data: data).array
                    if let json = json {
                        for item in json {
                            let id = item["_id"].stringValue
                            let name = item["name"].stringValue
                            let description = item["description"].stringValue
                            let channel = Channel(id: id, channelTitle: name, channelDescription: description)
                            self.channels.append(channel)
                        }
                    }
                    print(self.channels)
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                } catch {
                    print(error)
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    func findAllMessageForChannel(channelId: String, completion: @escaping completionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let newMessage = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            self.messages.append(newMessage)
                        }
                    }
                    print(self.messages)
                    completion(true)
                } catch {
                  print(error)
                    completion(false)
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
}
