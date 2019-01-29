//
//  Messages.swift
//  Simproofn
//
//  Created by Hamzhya on 28/01/19.
//  Copyright © 2019 Hamzhya. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Messages: NSObject, NSCoding {
    
    // property
    var name: String
    var avatar: UIImage?
    var subject: String
    var recieved: String
    var content: String
    
    // archiving paths
    static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static var ArchiveUrl = DocumentsDirectory.appendingPathComponent("messages")
    
    
    // types
    struct PropertyKey {
        static let name = "name"
        static let avatar = "avatar"
        static let subject = "subject"
        static let recieved = "recieved"
        static let content = "content"
    }
    
    // init
    init?(name: String, avatar: UIImage?, subject: String, recieved: String, content: String ) {
        
        // initialize stored props
        self.name = name
        self.avatar = avatar
        self.subject = subject
        self.recieved = recieved
        self.content = content
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(avatar, forKey: PropertyKey.avatar)
        aCoder.encode(subject, forKey: PropertyKey.subject)
        aCoder.encode(recieved, forKey: PropertyKey.recieved)
        aCoder.encode(content, forKey: PropertyKey.content)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("unable to decode the name for a message object", log: OSLog.default, type: .debug)
            return nil
        }
        guard let avatar = aDecoder.decodeObject(forKey: PropertyKey.avatar) as? UIImage else {
            os_log("unable to decode the name for a message object", log: OSLog.default, type: .debug)
            return nil
        }
        guard let subject = aDecoder.decodeObject(forKey: PropertyKey.subject) as? String else {
            os_log("unable to decode the name for a message object", log: OSLog.default, type: .debug)
            return nil
        }
        guard let recieved = aDecoder.decodeObject(forKey: PropertyKey.recieved) as? String else {
            os_log("unable to decode the name for a message object", log: OSLog.default, type: .debug)
            return nil
        }
        guard let content = aDecoder.decodeObject(forKey: PropertyKey.content) as? String else {
            os_log("unable to decode the name for a message object", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        self.init(name: name, avatar: avatar, subject: subject, recieved: recieved, content: content)
    }
    
    //
}
