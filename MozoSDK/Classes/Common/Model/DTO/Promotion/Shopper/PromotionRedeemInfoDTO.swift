//
//  PromotionRedeemInfoDTO.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 7/11/19.
//

import Foundation
import SwiftyJSON
public class PromotionRedeemInfoDTO {
    public var balanceInfoToken: TokenInfoDTO?
    public var promo: PromotionDTO?
    public var storeInfo: StoreInfoDTO?
    
    public required init?(json: SwiftyJSON.JSON) {
        self.balanceInfoToken = TokenInfoDTO(json: json["balanceInfoToken"])
        self.promo = PromotionDTO(json: json["promo"])
        self.storeInfo = StoreInfoDTO(json: json["storeInfo"])
    }
}