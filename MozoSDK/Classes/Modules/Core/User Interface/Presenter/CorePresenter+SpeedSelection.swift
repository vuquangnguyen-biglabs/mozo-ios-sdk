//
//  CorePresenter+SpeedSelection.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 6/10/19.
//

import Foundation
extension CorePresenter: SpeedSelectionModuleDelegate {
    func didSelectAutoWay() {
        coreWireframe?.processWalletAuto(isCreateNew: true)
    }
    
    func didSelectManualWay() {
        coreWireframe?.prepareForWalletInterface()
    }
    
    func didRequestLogoutInternally() {
        print("CorePresenter - Handle logout internally")
        coreWireframe?.requestForLogout()
    }
}
