//
//  TxHistoryDisplayItem.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 10/3/18.
//

import Foundation

public struct TxHistoryDisplayItem {
    let action : String
    let date : String
    let fromNameWithDate: NSAttributedString
    let amount: Double
    let exAmount: Double
    let txStatus: String
    
    var addressFrom: String?
    var addressTo: String?
    var topUpReason: TopUpReasonEnum?
    var nameOrAddress: String
    var fromtoText: String
    var name: String
    
    public init(action : String, date : String, fromNameWithDate: NSAttributedString, amount: Double, exAmount: Double, txStatus: String, addressFrom: String?, addressTo: String?, topUpReason: TopUpReasonEnum? = nil, nameOrAddress: String, fromtoText: String, name: String) {
        self.action = action
        self.date = date
        self.fromNameWithDate = fromNameWithDate
        self.amount = amount
        self.exAmount = exAmount
        self.txStatus = txStatus
        self.addressFrom = addressFrom
        self.addressTo = addressTo
        self.topUpReason = topUpReason
        self.nameOrAddress = nameOrAddress
        self.fromtoText = fromtoText
        self.name = name
    }
}
