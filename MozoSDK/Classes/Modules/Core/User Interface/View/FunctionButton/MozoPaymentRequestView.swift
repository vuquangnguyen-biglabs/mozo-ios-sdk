//
//  MozoPaymentRequestView.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 11/20/18.
//

@IBDesignable class MozoPaymentRequestView: MozoView {
    @IBOutlet weak var button: UIButton!
    
    override func identifier() -> String {
        return "MozoPaymentRequestView"
    }
    
    override func checkDisable() {
        if AccessTokenManager.getAccessToken() != nil {
            isUserInteractionEnabled = true
            button.backgroundColor = ThemeManager.shared.main
        } else {
            isUserInteractionEnabled = false
            button.backgroundColor = ThemeManager.shared.disable
        }
    }
    
    override func loadViewFromNib() {
        super.loadViewFromNib()
        addUniqueAuthObserver()
    }
    
    @IBAction func touchedUpInside(_ sender: Any) {
        print("Touched Up Inside Button Payment Request")
        
    }
}
