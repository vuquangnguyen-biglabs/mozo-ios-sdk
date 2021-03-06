//
//  WaitingViewController.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 11/29/18.
//

import Foundation
enum WaitingRetryAction {
    case LoadUserProfile
    case BuildAuth
}
class WaitingViewController: MozoBasicViewController {
    var eventHandler: CoreModuleWaitingInterface?
    @IBOutlet weak var imgLoading: UIImageView!
    
    var stopRotating = false
    // TODO: Rotate never stop
    
    var retryAction: WaitingRetryAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        rotateView()
        setupSpinningView()
    }
    
    func setupSpinningView() {
        let advTimeGif = UIImage.gifImageWithName("spinner")
        self.imgLoading.image = advTimeGif
    }
    
    private func rotateView(duration: Double = 1.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            self.imgLoading.transform = self.imgLoading.transform.rotated(by: CGFloat.pi)
        }) { finished in
            if !self.stopRotating {
                self.rotateView(duration: duration)
            } else {
                self.imgLoading.transform = .identity
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("WaitingViewController - View will disappear")
        if self.isMovingFromParentViewController {
            print("WaitingViewController - View will disappear - isMovingFromParentViewController")
            stopRotating = true
        }
    }
    
    func openSettings() {
        guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
extension WaitingViewController : PopupErrorDelegate {
    func didClosePopupWithoutRetry() {
        
    }
    
    func didTouchTryAgainButton() {
        if let retryAction = self.retryAction {
            print("User try reload user profile on waiting screen again.")
            switch retryAction {
            case .LoadUserProfile:
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(1)) {
                    self.eventHandler?.retryGetUserProfile()
                }
                break
            case .BuildAuth:
                self.eventHandler?.retryAuth()
                break
            }
            
        }
    }
}
extension WaitingViewController: WaitingViewInterface {
    func displayTryAgain(_ error: ConnectionError, forAction: WaitingRetryAction?) {
        self.retryAction = forAction
        if error == .apiError_INVALID_USER_TOKEN {
            displayMozoPopupTokenExpired()
        } else if error == .apiError_MAINTAINING {
            DisplayUtils.displayMaintenanceScreen()
        } else {
            if let topViewController = DisplayUtils.getTopViewController(), topViewController is WaitingViewController {
                DisplayUtils.displayTryAgainPopup(error: error, delegate: self)
            }
        }
    }
    
    func stopRotate() {
        stopRotating = true
    }
    
    func displayAlertIncorrectSystemDateTime() {
        let alert = UIAlertController(title: "The time on your device is incorrect.".localized,
                                      message: "Please update the date and time, then try again.".localized,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "Settings".localized, style: .default, handler: { (action) in
            (self.navigationController as? MozoNavigationController)?.tapCloseBtn()
            self.openSettings()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
