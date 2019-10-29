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
    
    func addMessage(messBody: String, userId: String, channelId: String, completion: @escaping completionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getChatMessage(completion: @escaping (_ mess: Message) -> Void) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            let newMessage = Message(message: messBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
            completion(newMessage)
        }
    }
    
    func getTypingUser(completion: @escaping (_ tyingUsers: [String: String]) -> Void) {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let tyingUsers = dataArray[0] as? [String: String] else { return }
            completion(tyingUsers)
        }
    }
}
