//
//  ResetPINWireframe.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 5/9/19.
//

import Foundation
class ResetPINWireframe: MozoWireframe {
    var walletWireframe: WalletWireframe?
    var presenter: ResetPINPresenter?
    var moduleRequested = Module.Wallet
    
    func presentResetPINInterface(requestFrom module: Module = Module.Wallet) {
        self.moduleRequested = module
        let viewController = viewControllerFromStoryBoard(ResetPINViewControllerIdentifier) as! ResetPINViewController
        viewController.eventHandler = presenter
        presenter?.viewInterface = viewController
        rootWireframe?.displayViewController(viewController)
    }
    
    func presentPINInterface(mnemonics: String) {
        walletWireframe?.presentPINInterface(passPharse: mnemonics, requestFrom: .ResetPIN)
    }
    
    func presentResetPINSuccessInterface() {
        // Pop ResetPINViewController
        rootWireframe?.dismissTopViewController()
        let viewController = viewControllerFromStoryBoard(ResetPINSuccessViewControllerIdentifier) as! ResetPINSuccessViewController
        viewController.eventHandler = presenter
        rootWireframe?.displayViewController(viewController)
    }
    
    func dismissResetPINInterface() {
        if moduleRequested == .Settings {
            dismissModuleInterface()
            return
        }
//        if moduleRequested == .Wallet {
//            walletWireframe?.walletPresenter?.handleEndingWalletFlow()
//        } else {
            // Pop ResetPINSuccessViewController
            rootWireframe?.dismissTopViewController()
//        }
        if let topViewController = rootWireframe?.mozoNavigationController.viewControllers.last, topViewController is PINViewController {
            walletWireframe?.updatePINInterfaceAfterResetPIN()
        }
    }
}
