//
//  AirdropPresenter.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 12/2/18.
//

import Foundation
class AirdropPresenter: NSObject {
    var wireframe: AirdropWireframe?
    var interactor: AirdropInteractorInput?
    weak var multiSignDelegate: MultiSignDelegate?
    weak var airdropEventDelegate: AirdropEventDelegate?
    
    var itemToSign: Signature?
    var airdropEvent: AirdropEventDTO?
    var tokenInfo: TokenInfoDTO?
    
    func requestMultiSign(signature: Signature) {
        itemToSign = signature
        wireframe?.presentPinInterfaceForMultiSign()
    }
    
    func createAirdropEvent(_ event: AirdropEventDTO) {
        self.airdropEvent = event
        interactor?.validateAndCalculateEvent(event)
    }
}
extension AirdropPresenter: PinModuleDelegate {
    func verifiedPINSuccess(_ pin: String) {
        wireframe?.removeDelegateAfterSigning()
        interactor?.sendSignedAirdropEventTx(pin: pin)
    }
}
extension AirdropPresenter: AirdropInteractorOutput {
    func didFailedToLoadTokenInfo() {
        airdropEventDelegate?.createAirdropEventFailure(error: "Unable to load tokenInfo.", isDisplayingTryAgain: true)
    }
    
    func didReceiveTxStatus(_ statusType: TransactionStatusType) {
        if statusType == .SUCCESS {
            airdropEventDelegate?.createAirdropEventSuccess()
            airdropEventDelegate = nil
        } else {
            airdropEventDelegate?.createAirdropEventFailure(error: "Airdrop event is created with failure status.", isDisplayingTryAgain: true)
            DisplayUtils.displayTryAgainPopup(delegate: self)
        }
    }
    
    func didSendSignedAirdropEventFailure(error: ConnectionError) {
        airdropEventDelegate?.createAirdropEventFailure(error: error.errorDescription, isDisplayingTryAgain: true)
        DisplayUtils.displayTryAgainPopup(delegate: self)
    }
    
    func requestPinInterface() {
        wireframe?.presentPinInterfaceForMultiSign()
    }
    
    func failedToSignAirdropEvent(error: String?) {
        airdropEventDelegate?.createAirdropEventFailure(error: error, isDisplayingTryAgain: false)
    }
    
    func failedToCreateAirdropEvent(error: String?) {
        airdropEventDelegate?.createAirdropEventFailure(error: error, isDisplayingTryAgain: false)
    }
}
extension AirdropPresenter: PopupErrorDelegate {
    func didTouchTryAgainButton() {
        self.createAirdropEvent(airdropEvent!)
    }
    
    func didClosePopupWithoutRetry() {
        interactor?.clearRetryPin()
    }
}