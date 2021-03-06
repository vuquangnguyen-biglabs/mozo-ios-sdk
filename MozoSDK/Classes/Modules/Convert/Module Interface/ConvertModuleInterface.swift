//
//  ConvertModuleInterface.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 3/9/19.
//

import Foundation
protocol ConvertModuleInterface {
    func loadEthAndOnchainInfo()
    func loadEthAndFeeTransfer()
    
    func loadEthAndOffchainInfo()
    
    func loadGasPrice()
    func openReadMore()
    func validateTxConvert(onchainInfo: OnchainInfoDTO, amount: String, gasPrice: NSNumber, gasLimit: NSNumber)
    
    func validateTxConvert(ethInfo: EthAndTransferFeeDTO, offchainInfo: OffchainInfoDTO, gasPrice: NSNumber, gasLimit: NSNumber)
    
    func sendConfirmConvertTx(_ tx: ConvertTransactionDTO)
}
