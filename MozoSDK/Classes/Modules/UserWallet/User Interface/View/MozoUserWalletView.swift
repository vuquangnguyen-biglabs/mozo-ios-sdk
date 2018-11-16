//
//  MozoUserWalletView.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 11/15/18.
//

import Foundation
let TX_HISTORY_TABLE_VIEW_CELL_IDENTIFIER = "TxHistoryTableViewCell"

@IBDesignable class MozoUserWalletView: MozoView {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var btnReload: UIButton!
    @IBOutlet weak var lbBalance: UILabel!
    @IBOutlet weak var imgMozo: UIImageView!
    @IBOutlet weak var lbBalanceExchange: UILabel!
    @IBOutlet weak var imgQR: UIImageView!
    @IBOutlet weak var btnShowQR: UIButton!
    
    @IBOutlet weak var paymentRequestView: UIView!
    @IBOutlet weak var sendMozoView: MozoSendView!
    
    @IBOutlet weak var historyTable: UITableView!
    
    var displayItem : DetailInfoDisplayItem?
    var collection : TxHistoryDisplayCollection? {
        didSet {
            historyTable.reloadData()
        }
    }
    
    override func identifier() -> String {
        return "MozoUserWalletView"
    }
    
    var isAnonymous: Bool = false
    override func loadViewFromNib() {
        if AccessTokenManager.getAccessToken() == nil
            || SessionStoreManager.loadCurrentUser() == nil {
            isAnonymous = true
        } else {
            isAnonymous = false
        }
        super.loadViewFromNib()
        loadDisplayData()
        setupTableView()
        setupButtonBorder()
        addOriginalObserver()
        addUniqueAuthObserver()
    }
    
    func setupTableView() {
        historyTable.register(UINib(nibName: TX_HISTORY_TABLE_VIEW_CELL_IDENTIFIER, bundle: BundleManager.mozoBundle()), forCellReuseIdentifier: TX_HISTORY_TABLE_VIEW_CELL_IDENTIFIER)
        historyTable.dataSource = self
        historyTable.delegate = self
        historyTable.tableFooterView = UIView()
    }
    
    func setupButtonBorder() {
//        infoView.dropShadow()
//        infoView.layer.shadowColor = UIColor(hexString: "a8c5ec").cgColor
        infoView.roundCorners(cornerRadius: 0.01, borderColor: ThemeManager.shared.disable, borderWidth: 0.5)
//        paymentRequestView.roundCorners(cornerRadius: 0.5, borderColor: .white, borderWidth: 1)
        sendMozoView.roundCorners(cornerRadius: 0.1 , borderColor: .white, borderWidth: 1)
    }

    func clearValueOnUI() {
        if lbBalance != nil {
            lbBalance.text = "0.0"
            lbBalanceExchange.text = "0.0"
        }
        collection = nil
    }

    func updateData(displayItem: DetailInfoDisplayItem) {
        if lbBalance != nil {
            addUniqueBalanceChangeObserver()
            updateOnlyBalance(displayItem.balance)
        }
        if imgQR != nil {
            if !displayItem.address.isEmpty {
                let qrImg = DisplayUtils.generateQRCode(from: displayItem.address)
                imgQR.image = qrImg
            }
        }
    }
    
    override func updateOnlyBalance(_ balance : Double) {
        print("Update balance on Mozo UI Components")
        if lbBalance != nil {
            lbBalance.text = "\(balance.rounded(toPlaces: 2))"
            var result = "0.0"
            if let rateInfo = SessionStoreManager.exchangeRateInfo {
                let type = CurrencyType(rawValue: rateInfo.currency?.uppercased() ?? "")
                if let type = type, let rateValue = rateInfo.rate {
                    let value = (balance * rateValue).rounded(toPlaces: type.decimalRound)
                    result = "\(type.unit)\(value)"
                }
            }
            lbBalanceExchange.text = result
        }
    }
    
    func loadDisplayData() {
        // Clear all data
        clearValueOnUI()
        if !isAnonymous {
            print("\(String(describing: self)) - Load display collection item data.")
            _ = MozoSDK.getTxHistoryDisplayCollection().done { (collectionData) in
                self.collection = collectionData
            }.catch({ (error) in
                
            })
            print("\(String(describing: self)) - Load display data.")
            if let item = SafetyDataManager.shared.detailDisplayData {
                print("\(String(describing: self)) - Receive display data: \(item)")
                self.updateData(displayItem: item)
                hideRefreshState()
            } else {
                print("\(String(describing: self)) - No data for displaying")
                let itemNoData = DetailInfoDisplayItem(balance: 0.0, address: "")
                self.updateData(displayItem: itemNoData)
                displayRefreshState()
            }
        } else {
            
        }
    }
    
    @IBAction func touchedViewAllHistory(_ sender: Any) {
        print("Touched Up Inside Button View All history")
        MozoSDK.displayTransactionHistory()
    }

    @IBAction func touchedShowQR(_ sender: Any) {
        print("Touch Show QR code button")
        if let address = displayItem?.address {
            DisplayUtils.displayQRView(address: address)
        }
    }
    
    // MARK: Refresh state
    var refreshView : MozoRefreshView?
    
    func displayRefreshState() {
        print("Display refresh state")
        if refreshView == nil {
            refreshView = MozoRefreshView(frame: containerView.frame)
            if refreshView != nil {
                addSubview(refreshView!)
            }
        } else {
            refreshView?.isHidden = false
            bringSubview(toFront: refreshView!)
        }
        refreshView?.isRefreshing = false
    }
    
    func hideRefreshState() {
        if refreshView != nil {
            print("Hide refresh state.")
            refreshView?.isHidden = true
            refreshView?.isRefreshing = false
        }
    }
    
    override func onLoadTokenInfoFailed(_ notification: Notification) {
        print("On Load Token Info Failed: Display refresh state")
        displayRefreshState()
    }
}
extension MozoUserWalletView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return collection != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection?.displayItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TX_HISTORY_TABLE_VIEW_CELL_IDENTIFIER, for: indexPath) as! TxHistoryTableViewCell
        let item = (collection?.displayItems[indexPath.row])!
        cell.txHistory = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
}
extension MozoUserWalletView : UITableViewDelegate {
    
}