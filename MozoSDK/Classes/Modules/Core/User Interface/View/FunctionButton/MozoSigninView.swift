//
//  SigninView.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 9/26/18.
//

import Foundation
import UIKit
@IBDesignable public class MozoSigninView: MozoView {
    @IBOutlet weak var button: UIButton!
        
    override func identifier() -> String {
        return "MozoSigninView"
    }
    
    override func checkDisable() {
        if AccessTokenManager.getAccessToken() != nil {
//            isUserInteractionEnabled = false
//            button.backgroundColor = ThemeManager.shared.disable
            let image = UIImage(named: "ic_logout", in: BundleManager.mozoBundle(), compatibleWith: nil)
            button.setImage(image, for: .normal)
            button.setTitle("Log Out MozoX".localized, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        } else {
//            isUserInteractionEnabled = true
//            button.backgroundColor = ThemeManager.shared.main
            let image = UIImage(named: "ic_user_white", in: BundleManager.mozoBundle(), compatibleWith: nil)
            button.setImage(image, for: .normal)
            button.setTitle("Sign In to MozoX".localized, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
        }
        button.backgroundColor = ThemeManager.shared.main
    }
    
    override func loadViewFromNib() {
        super.loadViewFromNib()
        addUniqueAuthObserver()
    }
    
    @IBAction func tapped(_ sender: Any) {
        print("Tapped Mozo Button Login")
        if AccessTokenManager.getAccessToken() != nil {
            MozoSDK.logout()
        } else {
            MozoSDK.authenticate()
        }
    }
}
