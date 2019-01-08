//
//  StoreBookDTO.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 1/8/19.
//

import Foundation
import SwiftyJSON

public class StoreBookDTO: ResponseObjectSerializable {
    
    public var id: Int64?
    public var ownerUid: String?
    public var name: String?
    public var physicalAddress: String?
    public var offchainAddress: String?

    public required init?(json: SwiftyJSON.JSON) {
        self.id = json["id"].int64
        self.ownerUid = json["ownerUid"].string
        self.name = json["name"].string
        self.offchainAddress = json["offchainAddress"].string
        self.physicalAddress = json["physicalAddress"].string
    }
    
    public required init?(){}
    
    public func toJSON() -> Dictionary<String, Any> {
        var json = Dictionary<String, Any>()
        if let id = self.id {
            json["id"] = id
        }
        if let ownerUid = self.ownerUid {
            json["ownerUid"] = ownerUid
        }
        if let name = self.name {
            json["name"] = name
        }
        if let offchainAddress = self.offchainAddress {
            json["offchainAddress"] = offchainAddress
        }
        if let physicalAddress = self.physicalAddress {
            json["physicalAddress"] = physicalAddress
        }
        return json
    }
    
    public static func arrayFromJson(_ json: SwiftyJSON.JSON) -> [StoreBookDTO] {
        let array = json.array?.filter({ StoreBookDTO(json: $0) != nil }).map({ StoreBookDTO(json: $0)! })
        return array ?? []
    }
    
    public static func arrayContainsItem(_ address: String, array: [StoreBookDTO]) -> Bool {
        return array.contains { $0.offchainAddress?.lowercased() == address.lowercased() }
    }
    
    public static func storeBookFromAddress(_ address: String, array: [StoreBookDTO]) -> StoreBookDTO? {
        if array.count == 0 {
            return nil
        }
        return array.first { $0.offchainAddress?.lowercased() == address.lowercased() }
    }
}
