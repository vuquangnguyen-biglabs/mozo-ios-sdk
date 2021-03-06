//
//  RdNotification.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 10/16/18.
//

import Foundation
import SwiftyJSON

public class RdNotification: ResponseObjectSerializable {
    public var event: String?
    
    public required init?(json: SwiftyJSON.JSON) {
        self.event = json["event"].string
    }
    
    public func toJSON() -> Dictionary<String, Any> {
        var json = Dictionary<String, Any>()
        if let event = self.event {
            json["event"] = event
        }
        return json
    }
}
