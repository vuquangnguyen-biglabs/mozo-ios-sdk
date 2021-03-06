//
//  TxHistoryApiManager.swift
//  MozoSDK
//
//  Created by HoangNguyen on 10/2/18.
//

import Foundation
import PromiseKit
import SwiftyJSON

public extension ApiManager {
    /// Call API to get a list transaction histories from an address.
    ///
    /// - Parameters:
    ///   - address: the address
    ///   - page: the number of page data
    ///   - size: the number of history item
    func getListTxHistory(address: String, page: Int = 0, size: Int = 15) -> Promise<[TxHistoryDTO]> {
        return Promise { seal in
            let url = Configuration.BASE_STORE_URL + TX_API_PATH + "txhistory/\(address)?page=\(page)&size=\(size)"
            self.execute(.get, url: url)
                .done { json -> Void in
                    // JSON info
                    print("Finish request to get list tx history, json response: \(json)")
                    let jobj = SwiftyJSON.JSON(json)[RESPONSE_TYPE_ARRAY_KEY]
                    let list = TxHistoryDTO.arrayFromJson(jobj)
                    seal.fulfill(list)
                }
                .catch { error in
                    print("Error when request get list tx history: " + error.localizedDescription)
                    //Handle error or give feedback to the user
                    guard let err = error as? ConnectionError else {
                        if error is AFError {
                            return seal.fulfill([])
                        }
                        return seal.reject(error)
                    }
                    seal.reject(err)
                }
                .finally {
                    //                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    /// Call API to get exchange rate info.
    ///
    func getExchangeRateInfo() -> Promise<RateInfoDTO> {
        return Promise { seal in
            let locale = Locale.current.languageCode ?? "en"
            let url = Configuration.BASE_URL + "/exchange/rate?locale=\(locale)"
            self.execute(.get, url: url)
                .done { json -> Void in
                    // JSON info
                    print("Finish request to get exchange rate info, json response: \(json)")
                    let jobj = SwiftyJSON.JSON(json)
                    let data = RateInfoDTO(json: jobj)
                    seal.fulfill(data!)
                }
                .catch { error in
                    print("Error when request get exchange rate info: " + error.localizedDescription)
                    seal.reject(error)
                }
                .finally {
                    //                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
