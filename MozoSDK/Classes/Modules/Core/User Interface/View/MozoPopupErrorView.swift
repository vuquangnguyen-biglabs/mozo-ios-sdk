//
//  MozoPopupErrorView.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 10/11/18.
//

import Foundation
protocol PopupErrorDelegate {
    func didTouchTryAgainButton()
}

class MozoPopupErrorView : MozoView {
    @IBOutlet weak var imgError: UIImageView!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var btnTry: UIButton!
    
    var error : ConnectionError = ConnectionError.internalServerError {
        didSet {
            setImageAndLabel()
        }
    }
    var delegate: PopupErrorDelegate?
    
    override func identifier() -> String {
        return "MozoPopupErrorView"
    }
    
    override func loadViewFromNib() {
        super.loadViewFromNib()
        setImageAndLabel()
    }
    
    func setImageAndLabel() {
        if error != ConnectionError.internalServerError {
           imgError.image = UIImage(named: "ic_no_connection", in: BundleManager.mozoBundle(), compatibleWith: nil)
           labelError.text = "There is no internet connection!"
        }
    }
    
    @IBAction func touchedTryBtn(_ sender: Any) {
        delegate?.didTouchTryAgainButton()
    }
}