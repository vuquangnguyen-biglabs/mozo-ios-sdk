//
//  PINViewController.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 8/28/18.
//  Copyright © 2018 Hoang Nguyen. All rights reserved.
//

import Foundation
import UIKit

class PINViewController : MozoBasicViewController {
    @IBOutlet weak var pinTextField: PinTextField!
    @IBOutlet weak var enterPINLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var confirmImg: UIImageView!
    @IBOutlet weak var forgotContainerView: UIView!
    
    var eventHandler : WalletModuleInterface?
    var passPhrase : String?
    var moduleRequested: Module = .Wallet
    var recoverFromServerEncryptedPhrase = false
    
    private var pin : String?
    private var isConfirm = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.passPhrase == nil {
            navigationItem.title = "Enter Security PIN".localized
        } else {
            if moduleRequested == .ResetPIN {
                navigationItem.title = "Reset PIN".localized
            } else {
                navigationItem.title = "Create Security PIN".localized
            }
        }
    }
    
    func configureView() {
        pinTextField.becomeFirstResponder()
        pinTextField.delegate = self as PinTextFieldDelegate
        pinTextField.keyboardType = .numberPad
        if self.passPhrase == nil {
            navigationItem.title = "Enter Security PIN".localized
            switch moduleRequested {
            case .Transaction, .Airdrop, .Convert:
                var text = "Enter your Security PIN\nto send MozoX"
                if moduleRequested == .Airdrop {
                    text = "Enter your Security PIN\nto create airdrop event"
                } else if moduleRequested == .Convert {
                    text = "Enter your Security PIN to convert MozoX from onchain to offchain."
                }
                enterPINLabel.text = text.localized
                descriptionLabel.text = "Security PIN must be 6 digits".localized
            default:
                // Enter new pin and confirm new pin
                enterPINLabel.text = "Enter your Security PIN\nto restore wallet".localized
            }
        }
        forgotContainerView.isHidden = passPhrase != nil
    }
    
    override public var prefersStatusBarHidden: Bool {
        return false
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func manageWallet() {
        if self.moduleRequested != .ResetPIN {
            if recoverFromServerEncryptedPhrase {
                self.eventHandler?.manageWalletToRecoverFromServerEncryptedPhrase(pin: self.pin!)
            } else {
                self.eventHandler?.manageWallet(passPhrase: self.passPhrase, pin: self.pin!)
            }
        } else {
            self.eventHandler?.manageWalletForResetPIN(passPhrase: self.passPhrase, pin: self.pin!)
        }
    }
    
    @IBAction func touchBtnForgot(_ sender: Any) {
        eventHandler?.displayResetPINInterface(requestFrom: moduleRequested)
    }
}

extension PINViewController: PinTextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: PinTextField) -> Bool {
        return true
    }
    
    func textFieldValueChanged(_ textField: PinTextField) {
        let value = textField.text ?? ""
        print("value changed: \(value)")
    }
    
    func textFieldShouldEndEditing(_ textField: PinTextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: PinTextField) {
        pinInputComplete(input: textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: PinTextField) -> Bool {
        return true
    }
}

extension PINViewController : PINViewInterface {
    func displayErrorAndLogout(_ error: ErrorApiResponse) {
        displayMozoAlertInfo(infoMessage: error.description) {
            MozoSDK.logout()
        }
    }
    
    func showCreatingInterface() {
        validationSuccess()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(900)) {
            self.hideAllUIs()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            print("PINViewController - Manage wallet after hide UIs")
            self.manageWallet()
        }
    }
    
    func showVerificationFailed() {
        validationFail()
    }
    
    func showConfirmPIN() {
        pinTextField.text = ""
        enterPINLabel.text = "Confirm Security PIN".localized
        descriptionLabel.text = "Re-enter your PIN".localized
        confirmImg.isHidden = false
        isConfirm = true
    }
    
    func displayError(_ error: String) {
        displayMozoError(error)
    }
    
    func displaySpinner() {
        displayMozoSpinner()
    }
    
    func removeSpinner() {
        removeMozoSpinner(hidesBackButton: true)
    }
    
    func displayTryAgain(_ error: ConnectionError) {
        DisplayUtils.displayTryAgainPopup(error: error, delegate: self)
    }
}
extension PINViewController : PopupErrorDelegate {
    func didClosePopupWithoutRetry() {
        
    }
    
    func didTouchTryAgainButton() {
        print("User try manage wallet again.")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(1)) {
            self.manageWallet()
        }
    }
}
private extension PINViewController {
    func hideAllUIs() {
        print("PINViewController - Hide all UIs")
        self.view.endEditing(true)
        view.subviews.forEach({ $0.isHidden = true })
        enterPINLabel.isHidden = false
        showActivityIndicator()
    }
    
    func showActivityIndicator() {
        var activityIndicator = UIActivityIndicatorView()
        
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        
        effectView.frame = CGRect(x: view.frame.midX - 23, y: view.frame.midY - 23, width: 46, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = ThemeManager.shared.main
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        view.addSubview(effectView)
    }
    
    func pinInputComplete(input: String) {
        if !isConfirm {
            pin = input
            if self.passPhrase != nil {
                eventHandler?.enterPIN(pin: input)
            } else {
                // TODO: Should handle freeze UI here
                if recoverFromServerEncryptedPhrase {
                    eventHandler?.verifyPINToRecoverFromServerEncryptedPhrase(pin: input)
                } else {
                    eventHandler?.verifyPIN(pin: input)
                }
            }
        } else {
            eventHandler?.verifyConfirmPIN(pin: pin!, confirmPin: input)
        }
    }
    
    func validationSuccess() {
        print("😍 success!")
        statusImg.isHidden = false
        statusLabel.isHidden = false
        confirmImg.isHighlighted = true
        pinTextField.isUserInteractionEnabled = false
        if !isConfirm {
            statusLabel.text = "Security PIN is correct".localized
        } else {
            statusLabel.text = "Create Security PIN successful".localized
        }
        statusLabel.textColor = ThemeManager.shared.success
    }
    
    func validationFail() {
        print("😞 failure!")
        statusImg.isHidden = true
        statusLabel.isHidden = false
        statusLabel.text = "Incorrect Security PIN".localized
        statusLabel.textColor = ThemeManager.shared.error
    }
}
