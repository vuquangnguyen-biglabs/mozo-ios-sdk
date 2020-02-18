//
//  BranchInfoDTO.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 2/7/20.
//

import Foundation
import SwiftyJSON

public class BranchInfoDTO : StoreInfoDTO {
    public var beacons: [BeaconInfoDTO]?
    public var images: [String]?
    
    public required init?(json: SwiftyJSON.JSON) {
        super.init(json: json)
        self.beacons = BeaconInfoDTO.arrayFromJson(json["beacons"])
        self.images = json["images"].array?.filter({ $0.string != nil }).map({ $0.string! })
    }
    
    public init?(address: String, city: String, closeHour: Int, country: String, imageLogo: String, latitude: NSNumber, longitude: NSNumber, name: String, openHour: Int, state: String, zip: String, images: [String], hashTag: [String]) {
        super.init()
        self.address = address
        self.city = city
        self.closeHour = closeHour
        self.country = country
        self.imageLogo = imageLogo
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.openHour = openHour
        self.state = state
        self.zip = zip
        self.images = images
        self.hashTag = hashTag
    }
    
    public init?(storeInfo: StoreInfoDTO) {
        super.init()
        self.city = storeInfo.city
        self.closeHour = storeInfo.closeHour
        self.country = storeInfo.country
        self.imageLogo = storeInfo.imageLogo
        self.openHour = storeInfo.openHour
        self.state = storeInfo.state
        self.zip = storeInfo.zip
        self.images = storeInfo.storeImages
        self.hashTag = storeInfo.hashTag
    }
    
    public override func toJSON() -> Dictionary<String, Any> {
        var json = super.toJSON()
        json["images"] = images
        return json
    }
    
    public static func branchArrayFromJson(_ json: SwiftyJSON.JSON) -> [BranchInfoDTO] {
        let array = json.array?.filter({ BranchInfoDTO(json: $0) != nil }).map({ BranchInfoDTO(json: $0)! })
        return array ?? []
    }
    
    public required init?() {
        super.init()
    }
    
    public required init(address: String) {
        super.init(address: address)
    }
    
    public required init(closeHour: Int) {
        super.init(closeHour: closeHour)
    }
    
    public required init(id: Int64) {
        super.init(id: id)
    }
    
    public required init(imageLogo: String?) {
        super.init(imageLogo: imageLogo)
    }
    
    public required init(long: NSNumber, lat: NSNumber) {
        super.init(long: long, lat: lat)
    }
    
    public required init(name: String) {
        super.init(name: name)
    }
    
    public required init(openHour: Int) {
        super.init(openHour: openHour)
    }
}
