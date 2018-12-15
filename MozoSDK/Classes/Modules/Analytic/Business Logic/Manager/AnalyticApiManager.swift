//
//  AnalyticApiManager.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 12/14/18.
//

import Foundation
import PromiseKit
import SwiftyJSON

let RETAILER_ANALYTICS_RESOURCE_API_PATH = "/retailer/analytics"
public extension ApiManager {
    public func getRetailerAnalyticHome() -> Promise<RetailerAnalyticsHomeDTO?> {
        return Promise { seal in
            let url = Configuration.BASE_STORE_URL + RETAILER_ANALYTICS_RESOURCE_API_PATH + "/home"
            self.execute(.get, url: url)
                .done { json -> Void in
                    // JSON info
                    print("Finish request to get retailer analytic home, json response: \(json)")
                    let jobj = SwiftyJSON.JSON(json)
                    let result = RetailerAnalyticsHomeDTO(json: jobj)
                    seal.fulfill(result)
                }
                .catch { error in
                    print("Error when request get retailer analytic home: " + error.localizedDescription)
                    seal.reject(error)
                }
                .finally {
                    //                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    public func getRetailerAnalyticList() -> Promise<[RetailerCustomerAnalyticDTO]> {
        return Promise { seal in
            let url = Configuration.BASE_STORE_URL + RETAILER_ANALYTICS_RESOURCE_API_PATH + "/customer-and-airdrop"
            self.execute(.get, url: url)
                .done { json -> Void in
                    // JSON info
                    print("Finish request to get retailer analytic list, json response: \(json)")
                    let array = SwiftyJSON.JSON(json)["array"]
                    let result = RetailerCustomerAnalyticDTO.arrayFromJson(array)
                    seal.fulfill(result)
                }
                .catch { error in
                    print("Error when request get retailer analytic list: " + error.localizedDescription)
                    seal.reject(error)
                }
                .finally {
                    //                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
