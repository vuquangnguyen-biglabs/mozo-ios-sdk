//
//  RDNInteractorIO.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 10/15/18.
//
protocol RDNInteractorInput {
    func startService()
    func stopService()
}

protocol RDNInteractorOutput {
    func balanceDidChange(balanceNoti: BalanceNotification)
    func addressBookDidChange(addressBookList: [AddressBookDTO])
}