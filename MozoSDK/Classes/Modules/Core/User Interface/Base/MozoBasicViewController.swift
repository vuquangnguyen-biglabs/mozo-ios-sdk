//
//  MozoBasicViewController.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 8/30/18.
//

import Foundation
import UIKit

public class MozoBasicViewController : UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    func enableBackBarButton() {
        self.navigationController?.navigationBar.backItem?.title = "Back"
        navigationItem.hidesBackButton = false
    }
    
    func displayMozoError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Spinner
    var mozoSpinnerView : UIView?
    
    func displayMozoSpinner() {
        navigationItem.hidesBackButton = true
        mozoSpinnerView = UIView.init(frame: self.view.bounds)
        mozoSpinnerView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.color = ThemeManager.shared.main
        ai.startAnimating()
        ai.center = (mozoSpinnerView?.center)!
        
        DispatchQueue.main.async {
            self.mozoSpinnerView?.addSubview(ai)
            self.view.addSubview(self.mozoSpinnerView!)
        }
    }
    
    func removeMozoSpinner() {
        DispatchQueue.main.async {
            self.navigationItem.hidesBackButton = false
            self.mozoSpinnerView?.removeFromSuperview()
        }
    }
    
    //MARK: Popup Error
    var mozoPopupErrorView : MozoPopupErrorView?
    
    func displayMozoPopupError(_ error: ConnectionError? = nil) {
        mozoPopupErrorView = MozoPopupErrorView(frame: CGRect(x: 0, y: 0, width: 315, height: 315))
        if let err = error {
            mozoPopupErrorView?.error = err
        }
        
        mozoPopupErrorView?.clipsToBounds = false
        mozoPopupErrorView?.dropShadow()
        mozoPopupErrorView?.containerView.roundCorners(borderColor: .white, borderWidth: 1)
        
        mozoPopupErrorView?.center = view.center
        UIView.transition(with: view, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            self.view.addSubview(self.mozoPopupErrorView!)
        }) { (_) in
        }
    }
    
    func removeMozoPopupError() {
        DispatchQueue.main.async {
            self.mozoPopupErrorView?.removeFromSuperview()
        }
    }
}
