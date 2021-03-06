//
//  TicketApiManager.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 10/1/19.
//

import Foundation
import PromiseKit
import SwiftyJSON

let SHOPPER_PARKING_TICKET_API_PATH = SHOPPER_API_PATH + "/parking-ticket"

public extension ApiManager {
    func getParkingTicketStatus(id: Int64, isIn: Bool) -> Promise<ParkingTicketStatusType> {
        return Promise { seal in
            let url = Configuration.BASE_STORE_URL + SHOPPER_PARKING_TICKET_API_PATH + "/getParkingTicketStatus?id=\(id)&in=\(isIn)"
            NSLog("ApiManager - Get parking ticket status with url: \(url)")
            self.execute(.get, url: url)
                .done { json -> Void in
                    // JSON info
                    NSLog("Finish request to get parking ticket status, json response: \(json)")
                    if let jobj = SwiftyJSON.JSON(json)[RESPONSE_TYPE_STATUS_KEY].string,
                        let status = ParkingTicketStatusType(rawValue: jobj){
                        seal.fulfill(status)
                    }
                }
                .catch { error in
                    NSLog("Error when request get parking ticket status: " + error.localizedDescription)
                    seal.reject(error)
                }
                .finally {
                    //                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    func getParkingTicketByStoreId(storeId: Int64, isIn: Bool) -> Promise<TicketDTO> {
        return Promise { seal in
            let url = Configuration.BASE_STORE_URL + SHOPPER_PARKING_TICKET_API_PATH + "/getParkingTicketByStoreId/v2?storeId=\(storeId)&in=\(isIn)&locale=\(Configuration.LOCALE)"
            self.execute(.get, url: url)
                .done { json -> Void in
                    // JSON info
                    print("Finish request to get parking ticket by store id [\(storeId)], json response: \(json)")
                    let jobj = SwiftyJSON.JSON(json)
                    if let ticket = TicketDTO(json: jobj) {
                        seal.fulfill(ticket)
                    } else {
                        seal.reject(ConnectionError.systemError)
                    }
                }
                .catch { error in
                    print("Error when request get parking ticket by store id [\(storeId)]: " + error.localizedDescription)
                    seal.reject(error)
                }
                .finally {
                    //                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    func getParkingTicketByStoreId(storeId: Int64) -> Promise<TicketDTO> {
        return Promise { seal in
            let url = Configuration.BASE_STORE_URL + SHOPPER_PARKING_TICKET_API_PATH + "/getParkingTicketByStoreIdWithoutInOut?storeId=\(storeId)&locale=\(Configuration.LOCALE)"
            self.execute(.get, url: url)
                .done { json -> Void in
                    // JSON info
                    print("Finish request to get parking ticket by store id ONLY [\(storeId)], json response: \(json)")
                    let jobj = SwiftyJSON.JSON(json)
                    if let ticket = TicketDTO(json: jobj) {
                        seal.fulfill(ticket)
                    } else {
                        seal.reject(ConnectionError.systemError)
                    }
                }
                .catch { error in
                    print("Error when request get parking ticket by store id ONLY [\(storeId)]: " + error.localizedDescription)
                    seal.reject(error)
                }
                .finally {
                    //                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    func renewParkingTicket(id: Int64, vehicleTypeKey: String, isIn: Bool) -> Promise<TicketDTO> {
        return Promise { seal in
            let url = Configuration.BASE_STORE_URL + SHOPPER_PARKING_TICKET_API_PATH + "/getRenewParkingTicket?id=\(id)&locale=\(Configuration.LOCALE)&in=\(isIn.toString)&vehicleTypeKey=\(vehicleTypeKey)"
            self.execute(.get, url: url)
                .done { json -> Void in
                    // JSON info
                    print("Finish request to renew parking ticket by id [\(id)], json response: \(json)")
                    let jobj = SwiftyJSON.JSON(json)
                    if let ticket = TicketDTO(json: jobj) {
                        seal.fulfill(ticket)
                    } else {
                        seal.reject(ConnectionError.systemError)
                    }
                }
                .catch { error in
                    print("Error when request renew parking ticket by id [\(id)]: " + error.localizedDescription)
                    seal.reject(error)
                }
                .finally {
                    //                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
