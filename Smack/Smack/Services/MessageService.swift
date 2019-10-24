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
}
