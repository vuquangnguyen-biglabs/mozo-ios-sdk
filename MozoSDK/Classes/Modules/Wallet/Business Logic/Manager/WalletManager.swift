//
//  WalletManager.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 8/27/18.
//  Copyright © 2018 Hoang Nguyen. All rights reserved.
//

import Foundation
import web3swift

class WalletManager : NSObject {
    
    func generateMnemonics() -> String? {
        let mnemonics = try! BIP39.generateMnemonics(bitsOfEntropy: 128)
        return mnemonics
//        printTest()
    }
    
    func createNewWallets(mnemonics: String) -> [WalletModel] {
        let path = HDNode.defaultPathMetamaskPrefix
        // Return empty if keystore is unable to created
        do {
            if let keystore = try BIP32Keystore(mnemonics: mnemonics, password: "", mnemonicsPassword: "", prefixPath: path) {
                if keystore.addresses?.count ?? 0 == 0 {
                    return []
                }
                
                if let offchainAccount = keystore.addresses?[0] {
                    var wallets: [WalletModel] = []
                    let offchainKey = try keystore.UNSAFE_getPrivateKeyData(password: "", account: offchainAccount)
                    let offchainWallet = WalletModel.init(address: offchainAccount.address, privateKey: offchainKey.toHexString())
                    wallets.append(offchainWallet)
                    
                    _ = try keystore.createNewChildAccount(password: "")
                    // Paths are stored as an dictionary so we must check the address for sure.
                    if let onchainAccount = keystore.addresses?.first(where: { $0.address != offchainAccount.address }) {
                        let onchainKey = try keystore.UNSAFE_getPrivateKeyData(password: "", account: onchainAccount)
                        let onchainWallet = WalletModel.init(address: onchainAccount.address, privateKey: onchainKey.toHexString())
                        wallets.append(onchainWallet)
                    }
                    
                    return wallets
                }
            }
        } catch let ex {
            NSLog("WalletManager - createNewWallets exception: \(ex)")
        }
        return []
    }
    
    func printTest() {
        let importedMnemonic = "test pizza drift whip rebel empower flame mother service grace sweet kangaroo"
        let seed = BIP39.seedFromMmemonics(importedMnemonic)
        print("Seed: [\(seed?.toHexString() ?? "")]")
        
        let path = "m/44'/60'/0'/0"
        let keystore = try! BIP32Keystore(mnemonics: importedMnemonic, password: "", mnemonicsPassword: "", prefixPath: path)
        let account = keystore!.addresses![0]
        print("Address: [\(account.address)]")
        let key = try! keystore!.UNSAFE_getPrivateKeyData(password: "", account: account)
        print("Private key: [\(key.toHexString())]")
        let pubKey = Web3.Utils.privateToPublic(key, compressed: true)
        print("Public key: [\(pubKey?.toHexString() ?? "")]")
    }
}
