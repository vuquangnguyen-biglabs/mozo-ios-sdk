//
//  MaintenanceInteractor.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 5/14/19.
//

import Foundation
class MaintenanceInteractor: NSObject {
    var output: MaintenanceInteractorOutput?
    var txStatusTimer: Timer?
    
    @objc func loadMaintenanceStatus() {
        NSLog("MaintenanceInteractor - Load Maintenance Status")
        ApiManager.checkMaintenence().done({ (type) in
            self.handleWaitingCompleted(statusType: type)
        }).catch({ (error) in
//            self.stopService()
            self.output?.didReceiveError(error: error as? ConnectionError ?? .systemError)
        })
    }
    
    func handleWaitingCompleted(statusType: MaintenanceStatusType) {
        NSLog("MaintenanceInteractor - Handle waiting maintenance completed")
        if statusType != .MAINTAINED {
            self.output?.didReceiveMaintenanceStatus(statusType)
            self.stopService()
        }
    }
}
extension MaintenanceInteractor: MaintenanceInteractorInput {
    func startWaitingMaintenanceStatus() {
        NSLog("MaintenanceInteractor - Start waiting maintenance service")
        txStatusTimer = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(loadMaintenanceStatus), userInfo: nil, repeats: true)
    }
    
    func stopService() {
        NSLog("MaintenanceInteractor - Stop service")
        txStatusTimer?.invalidate()
        txStatusTimer = nil
    }
}
