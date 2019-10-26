//
//  SocketService.swift
//  Smack
//
//  Created by Trinh Thai on 10/26/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    var manager: SocketManager
    var socket: SocketIOClient
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: URL_BASE)!)
        self.socket = self.manager.defaultSocket
        super.init()
    }
    
    func establishConnection(){
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(name: String, description: String, completion: @escaping completionHandler) {
        socket.emit("newChannel", name, description)
        completion(true)
    }
    
    func getChannel(completion: @escaping completionHandler) {
        socket.on("channelCreated") { (dataArr, ack) in
            let name = dataArr[0] as? String
            let des = dataArr[0] as? String
            let id = dataArr[0] as? String
            let newChannel = Channel(id: id, channelTitle: name, channelDescription: des)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
}
