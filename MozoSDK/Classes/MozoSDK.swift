//
//  MozoSDK.swift
//  MozoSDK
//
//  Created by Hoang Nguyen on 8/27/18.
//  Copyright © 2018 Hoang Nguyen. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit
import SwiftyJSON

public class MozoSDK {
    private static var moduleDependencies: ModuleDependencies!
    
    public static func configure(apiKey: String = Configuration.API_KEY_DEFAULT, network: MozoNetwork = .TestNet, appType: AppType = .Shopper) {
        Configuration.SUB_DOMAIN_ENUM = network.serviceType
        moduleDependencies = ModuleDependencies()
        moduleDependencies.apiKey = apiKey
        moduleDependencies.network = network
        moduleDependencies.appType = appType
    }
    
    public static func setAuthDelegate(_ delegate: AuthenticationDelegate) {
        moduleDependencies.setAuthDelegate(delegate)
    }
    
    public static func isNetworkReachable() -> Bool {
        return moduleDependencies.isNetworkReachable()
    }
    
    public static func authenticate() {
        moduleDependencies.authenticate()
    }
    
    public static func processAuthorizationCallBackUrl(_ url: URL) {
        moduleDependencies.processAuthorizationCallBackUrl(url)
    }
    
    public static func logout() {
        moduleDependencies.logout()
    }
    
    public static func transferMozo() {
        moduleDependencies.transferMozo()
    }
    
    public static func displayTransactionHistory() {
        moduleDependencies.displayTransactionHistory()
    }
    
    public static func displayPaymentRequest() {
        moduleDependencies.displayPaymentRequest()
    }
    
    public static func displayAddressBook() {
        moduleDependencies.displayAddressBook()
    }
    
    public static func convertMozoXOnchain(isConvertOffchainToOffchain: Bool = false) {
        moduleDependencies.convertMozoXOnchain(isConvertOffchainToOffchain: isConvertOffchainToOffchain)
    }
    
    public static func displayTransactionDetail(txHistory: TxHistoryDisplayItem, tokenInfo: TokenInfoDTO) {
        moduleDependencies.displayTransactionDetail(txHistory: txHistory, tokenInfo: tokenInfo)
    }
    
    public static func loadBalanceInfo() -> Promise<DetailInfoDisplayItem> {
        return (moduleDependencies.loadBalanceInfo())
    }
    
    public static func loadEthAndOnchainBalanceInfo() -> Promise<OnchainInfoDTO> {
        return (moduleDependencies.loadEthAndOnchainBalanceInfo())
    }
    
    public static func registerBeacon(parameters: Any?) -> Promise<[String: Any]> {
        return (moduleDependencies.registerBeacon(parameters: parameters))
    }
    
    public static func updateBeaconSettings(parameters: Any?) -> Promise<[String: Any]> {
        return (moduleDependencies.updateBeaconSettings(parameters: parameters))
    }
    
    public static func deleteBeacon(beaconId: Int64) -> Promise<Bool> {
        return (moduleDependencies.deleteBeacon(beaconId: beaconId))
    }
    
    public static func getListBeacons() -> Promise<[String : Any]> {
        return (moduleDependencies.getListBeacons())
    }
    
    public static func getRetailerInfo() -> Promise<[String : Any]> {
        return (moduleDependencies.getRetailerInfo())
    }
    
    public static func addRetailerSalePerson(parameters: Any?) -> Promise<[String: Any]> {
        return (moduleDependencies.addRetailerSalePerson(parameters:parameters))
    }
    
    public static func getAirdropStoreNearby(params: [String: Any]) -> Promise<[AirdropEventDiscoverDTO]> {
        return (moduleDependencies.getAirdropStoreNearby(params: params))
    }
    
    public static func sendRangedBeacons(beacons: [BeaconInfoDTO], status: Bool) -> Promise<[String : Any]> {
        return (moduleDependencies.sendRangedBeacons(beacons: beacons, status: status))
    }
    
    public static func getRangeColorSettings() -> Promise<[AirdropColorRangeDTO]> {
        return (moduleDependencies.getRangeColorSettings())
    }
    
    public static func getTxHistoryDisplayCollection() -> Promise<TxHistoryDisplayCollection> {
        return (moduleDependencies.getTxHistoryDisplayCollection())
    }
    
    public static func createAirdropEvent(event: AirdropEventDTO, delegate: AirdropEventDelegate) {
        return (moduleDependencies.createAirdropEvent(event: event, delegate: delegate))
    }
    
    public static func addMoreMozoToAirdropEvent(event: AirdropEventDTO, delegate: AirdropAddEventDelegate) {
        return (moduleDependencies.addMoreMozoToAirdropEvent(event: event, delegate: delegate))
    }
    
    public static func withdrawMozoFromAirdropEventId(_ eventId: Int64, delegate: WithdrawAirdropEventDelegate) {
        return (moduleDependencies.withdrawMozoFromAirdropEventId(eventId, delegate: delegate))
    }
    
    public static func getLatestAirdropEvent() -> Promise<AirdropEventDTO> {
        return moduleDependencies.getLatestAirdropEvent()
    }
    
    public static func getAirdropEventList(page: Int, branchId: Int64? = nil) -> Promise<[AirdropEventDTO]> {
        return moduleDependencies.getAirdropEventList(page: page, branchId: branchId)
    }
    
    public static func getRetailerAnalyticHome() -> Promise<RetailerAnalyticsHomeDTO?> {
        return moduleDependencies.getRetailerAnalyticHome()
    }
    
    public static func getRetailerAnalyticList() -> Promise<[RetailerCustomerAnalyticDTO]> {
        return moduleDependencies.getRetailerAnalyticList()
    }
    
    public static func getVisitCustomerList(page: Int, size: Int = 15, year: Int = 0, month: Int = 0) -> Promise<[VisitedCustomerDTO]> {
        return moduleDependencies.getVisitCustomerList(page: page, size: size, year: year, month: month)
    }
    
    public static func getRetailerAnalyticAmountAirdropList(page: Int, size: Int = 15, year: Int = 0, month: Int = 0) -> Promise<[AirDropReportDTO]> {
        return moduleDependencies.getRetailerAnalyticAmountAirdropList(page: page, size: size, year: year, month: month)
    }
    
    public static func getRunningAirdropEvents(page: Int = 0, size: Int = 5) -> Promise<[AirdropEventDTO]> {
        return moduleDependencies.getRunningAirdropEvents(page: page, size: size)
    }
    
    public static func getListSalePerson() -> Promise<[SalePersonDTO]> {
        return moduleDependencies.getListSalePerson()
    }
    
    public static func removeSalePerson(id: Int64) -> Promise<[String: Any]> {
        return moduleDependencies.removeSalePerson(id: id)
    }
    
    public static func getListCountryCode() -> Promise<[CountryCodeDTO]> {
        return moduleDependencies.getListCountryCode()
    }
    
    public static func getListEventAirdropOfStore(_ storeId: Int64) -> Promise<[AirdropEventDiscoverDTO]> {
        return moduleDependencies.getListEventAirdropOfStore(storeId)
    }
    
    public static func searchStoresWithText(_ text: String, page: Int = 0, size: Int = 15, long: Double, lat: Double, sort: String = "distance") -> Promise<CollectionStoreInfoDTO> {
        return moduleDependencies.searchStoresWithText(text, page: page, size: size, long: long, lat: lat, sort: sort)
    }
    
    public static func getFavoriteStores(page: Int = 0, size: Int = 15) -> Promise<[BranchInfoDTO]> {
        return moduleDependencies.getFavoriteStores(page: page, size: size)
    }
    
    public static func updateFavoriteStore(_ storeId: Int64, isMarkFavorite: Bool) -> Promise<[String: Any]> {
        return moduleDependencies.updateFavoriteStore(storeId, isMarkFavorite: isMarkFavorite)
    }
    
    public static func getTodayCollectedAmount(startTime: Int = 0, endTime: Int = 86400) -> Promise<NSNumber> {
        return moduleDependencies.getTodayCollectedAmount(startTime: startTime, endTime: endTime)
    }
    
    public static func getUrlToUploadImage() -> Promise<String> {
        return moduleDependencies.getUrlToUploadImage()
    }
    
    public static func uploadImage(images: [UIImage], url: String, progressionHandler: @escaping (_ fractionCompleted: Double)-> Void) -> Promise<[String]> {
        return moduleDependencies.uploadImage(images: images, url: url, progressionHandler: progressionHandler)
    }
    
    public static func updateUserProfile(userProfile: UserProfileDTO) -> Promise<UserProfileDTO> {
        return moduleDependencies.updateUserProfile(userProfile: userProfile)
    }
    
    public static func updateAvatarToUserProfile(userProfile: UserProfileDTO) -> Promise<UserProfileDTO> {
        return moduleDependencies.updateAvatarToUserProfile(userProfile: userProfile)
    }
    
    public static func getCommonHashtag() -> Promise<[String]> {
        return moduleDependencies.getCommonHashtag()
    }
    
    public static func deleteRetailerStoreInfoPhotos(photos: [String]) -> Promise<StoreInfoDTO> {
        return moduleDependencies.deleteRetailerStoreInfoPhotos(photos: photos)
    }
    
    public static func updateRetailerStoreInfoPhotos(photos: [String]) -> Promise<StoreInfoDTO> {
        return moduleDependencies.updateRetailerStoreInfoPhotos(photos: photos)
    }
    
    public static func updateRetailerStoreInfoHashtag(hashTags: [String]) -> Promise<StoreInfoDTO> {
        return moduleDependencies.updateRetailerStoreInfoHashtag(hashTags: hashTags)
    }
    
    public static func updateRetailerStoreInfo(storeInfo: StoreInfoDTO) -> Promise<StoreInfoDTO> {
        return moduleDependencies.updateRetailerStoreInfo(storeInfo: storeInfo)
    }
    
    public static func getStoreDetail(_ storeId: Int64) -> Promise<BranchInfoDTO> {
        return moduleDependencies.getStoreDetail(storeId)
    }
    
    public static func getRecommendationStores(_ storeId: Int64, size: Int = 5, long: Double?, lat: Double?) -> Promise<[BranchInfoDTO]> {
        return moduleDependencies.getRecommendationStores(storeId, size: size, long: long, lat: lat)
    }
    
    public static func handleAccessRemove() {
        return moduleDependencies.handleAccessRemove()
    }
    
    public static func getDiscoverAirdrops(type: AirdropEventDiscoverType, page: Int, size: Int, long: Double, lat: Double) -> Promise<[String: Any]> {
        return moduleDependencies.getDiscoverAirdrops(type: type, page: page, size: size, long: long, lat: lat)
    }
    
    public static func requestSupportBeacon(info: SupportRequestDTO) -> Promise<[String: Any]> {
        return moduleDependencies.requestSupportBeacon(info: info)
    }
    
    public static func getOffchainTokenInfo() -> Promise<OffchainInfoDTO> {
        return moduleDependencies.getOffchainTokenInfo()
    }
    
    public static func getInviteLink(locale: String, inviteAppType: AppType) -> Promise<InviteLinkDTO> {
        return moduleDependencies.getInviteLink(locale: locale, inviteAppType: inviteAppType)
    }
    
    public static func getListLanguageInfo() -> Promise<[InviteLanguageDTO]> {
        return moduleDependencies.getListLanguageInfo()
    }
    
    public static func updateCodeLinkInstallApp(codeString: String) -> Promise<InviteLinkDTO> {
        return moduleDependencies.updateCodeLinkInstallApp(codeString: codeString)
    }
    
    public static func processInvitationCode() {
        return moduleDependencies.processInvitationCode()
    }
    
    public static func getListNotification(page: Int = 0, size: Int = 15) -> Promise<[WSMessage]> {
        return moduleDependencies.getListNotification(page: page, size: size)
    }
    
    public static func getSuggestKeySearch(lat: Double = 0, lon: Double = 0) -> Promise<[String]> {
        return moduleDependencies.getSuggestKeySearch(lat: lat, lon: lon)
    }
    
    public static func loadUserProfile() -> Promise<UserProfileDTO> {
        return moduleDependencies.loadUserProfile()
    }
    
    public static func getCreateAirdropEventSettings() -> Promise<AirdropEventSettingDTO> {
        return moduleDependencies.getCreateAirdropEventSettings()
    }
    
    public static func requestForChangePin() {
        return moduleDependencies.requestForChangePin()
    }
    
    public static func requestForBackUpWallet() {
        return moduleDependencies.requestForBackUpWallet()
    }
    
    public static func getPromoCreateSetting() -> Promise<PromotionSettingDTO> {
        return moduleDependencies.getPromoCreateSetting()
    }
    
    public static func createPromotion(_ promotion: PromotionDTO) -> Promise<[String: Any]> {
        return moduleDependencies.createPromotion(promotion)
    }
    
    public static func getRetailerPromotionList(page: Int = 0, size: Int = 15, statusRequest: PromotionStatusRequestEnum = .RUNNING) -> Promise<[PromotionDTO]> {
        return moduleDependencies.getRetailerPromotionList(page: page, size: size, statusRequest: statusRequest)
    }
    
    public static func processPromotionCode(code: String) -> Promise<PromotionCodeInfoDTO> {
        return moduleDependencies.processPromotionCode(code: code)
    }
    
    public static func usePromotionCode(code: String, billInfo: String?) -> Promise<PromotionCodeInfoDTO> {
        return moduleDependencies.usePromotionCode(code: code, billInfo: billInfo)
    }
    
    public static func cancelPromotionCode(code: String) -> Promise<[String: Any]> {
        return moduleDependencies.cancelPromotionCode(code: code)
    }
    
    public static func getShopperPromotionListWithType(page: Int = 0, size: Int = 15, long: Double = 0, lat: Double = 0, type: PromotionListTypeEnum = .TOP) -> Promise<[PromotionStoreDTO]> {
        return moduleDependencies.getShopperPromotionListWithType(page: page, size: size, long: long, lat: lat, type: type)
    }
    
    public static func getPromotionRedeemInfo(promotionId: Int64) -> Promise<PromotionRedeemInfoDTO> {
        return moduleDependencies.getPromotionRedeemInfo(promotionId: promotionId)
    }
    
    public static func redeemPromotion(_ promotionId: Int64, delegate: RedeemPromotionDelegate) {
        return moduleDependencies.redeemPromotion(promotionId, delegate: delegate)
    }
    
    public static func getPromotionPaidDetail(promotionId: Int64) -> Promise<PromotionPaidDTO> {
        return moduleDependencies.getPromotionPaidDetail(promotionId: promotionId)
    }
    
    public static func getPromotionPaidDetailByCode(_ promotionCode: String) -> Promise<PromotionPaidDTO> {
        return moduleDependencies.getPromotionPaidDetailByCode(promotionCode)
    }
    
    public static func updateFavoritePromotion(_ promotionId: Int64, isFavorite: Bool) -> Promise<[String: Any]> {
        return moduleDependencies.updateFavoritePromotion(promotionId, isFavorite: isFavorite)
    }
    
    public static func getPromotionPaidHistoryDetail(_ id: Int64) -> Promise<PromotionPaidDTO> {
        return moduleDependencies.getPromotionPaidHistoryDetail(id)
    }
    
    public static func getShopperPromotionSaved(page: Int = 0, size: Int = 15, long: Double = 0, lat: Double = 0) -> Promise<[PromotionStoreDTO]> {
        return moduleDependencies.getShopperPromotionSaved(page: page, size: size, long: long, lat: lat)
    }
    
    public static func getShopperPromotionRunning(page: Int = 0, size: Int = 15, long: Double = 0, lat: Double = 0, storeId: Int64) -> Promise<JSON> {
        return moduleDependencies.getShopperPromotionRunning(page: page, size: size, long: long, lat: lat, storeId: storeId)
    }
    
    public static func getShopperPromotionPurchased(page: Int = 0, size: Int = 15, long: Double = 0, lat: Double = 0) -> Promise<[PromotionStoreDTO]> {
        return moduleDependencies.getShopperPromotionPurchased(page: page, size: size, long: long, lat: lat)
    }
    
    public static func getShopperPromotionHistory(page: Int = 0, size: Int = 15) -> Promise<[PromotionStoreDTO]> {
        return moduleDependencies.getShopperPromotionHistory(page: page, size: size)
    }
    
    public static func getRetailerPromotionScannedList(page: Int = 0, size: Int = 15) -> Promise<[PromotionCodeInfoDTO]> {
        return moduleDependencies.getRetailerPromotionScannedList(page: page, size: size)
    }
    
    public static func getRetailerCountPromotion() -> Promise<Int> {
        return moduleDependencies.getRetailerCountPromotion()
    }
    
    public static func getShopperTodoList(blueToothOff: Bool, long: Double, lat: Double) -> Promise<[TodoDTO]> {
        return moduleDependencies.getShopperTodoList(blueToothOff: blueToothOff, long: long, lat: lat)
    }
    
    public static func getTodoListSetting() -> Promise<TodoSettingDTO> {
        return moduleDependencies.getTodoListSetting()
    }
    
    public static func getGPSBeacons(userLat: Double, userLong: Double) -> Promise<[String]> {
        return moduleDependencies.getGPSBeacons(userLat: userLat, userLong: userLong)
    }
    
    public static func searchPromotionsWithText(_ text: String, page: Int = 0, size: Int = 15, long: Double = 0, lat: Double = 0) -> Promise<CollectionPromotionInfoDTO> {
        return moduleDependencies.searchPromotionsWithText(text, page: page, size: size, long: long, lat: lat)
    }
    
    public static func getSuggestKeySearchForPromotion(lat: Double = 0, lon: Double = 0) -> Promise<[String]> {
        return moduleDependencies.getSuggestKeySearchForPromotion(lat: lat, lon: lon)
    }
    
    // MARK: PARKING TICKET
    
    public static func getParkingTicketStatus(id: Int64, isIn: Bool) -> Promise<ParkingTicketStatusType> {
        return moduleDependencies.getParkingTicketStatus(id: id, isIn: isIn)
    }
    
    public static func getParkingTicketByStoreId(storeId: Int64, isIn: Bool) -> Promise<TicketDTO> {
        return moduleDependencies.getParkingTicketByStoreId(storeId: storeId, isIn: isIn)
    }
    
    public static func getParkingTicketByStoreId(storeId: Int64) -> Promise<TicketDTO> {
        return moduleDependencies.getParkingTicketByStoreId(storeId: storeId)
    }
        
    public static func renewParkingTicket(id: Int64, vehicleTypeKey: String, isIn: Bool) -> Promise<TicketDTO> {
        return moduleDependencies.renewParkingTicket(id: id, vehicleTypeKey: vehicleTypeKey, isIn: isIn)
    }
    
    // MARK: TOP UP
    public static func loadTopUpBalanceInfo() -> Promise<DetailInfoDisplayItem> {
        return (moduleDependencies.loadTopUpBalanceInfo())
    }
    
    public static func loadTopUpHistory(page: Int = 0, size: Int = 15) -> Promise<TxHistoryDisplayCollection> {
        return (moduleDependencies.loadTopUpHistory(page: page, size: size))
    }
    
    public static func openTopUpTransfer(delegate: TopUpDelegate) {
        moduleDependencies.openTopUpTransfer(delegate: delegate)
    }
    
    public static func topUpWithdraw(delegate: TopUpWithdrawDelegate) {
        moduleDependencies.topUpWithdraw(delegate: delegate)
    }
    
    public static func getShopperPromotionInStore(storeId: Int64, type: PromotionListTypeEnum, page: Int = 0, size: Int = 5, long: Double, lat: Double) -> Promise<[PromotionStoreDTO]> {
        moduleDependencies.getShopperPromotionInStore(storeId: storeId, type: type, page: page, size: size, long: long, lat: lat)
    }
    
    public static func getAirdropEventFromStore(_ storeId: Int64, type: AirdropEventType, page: Int, size: Int) -> Promise<[AirdropEventDiscoverDTO]> {
        return moduleDependencies.getAirdropEventFromStore(storeId, type: type, page: page, size: size)
    }
    
    public static func getPromotionStoreGroup(page: Int, size: Int, long: Double, lat: Double) -> Promise<JSON> {
        return moduleDependencies.getPromotionStoreGroup(page: page, size: size, long: long, lat: lat)
    }
    
    public static func confirmStoreInfoMerchant(branchInfo: BranchInfoDTO) -> Promise<BranchInfoDTO> {
        return moduleDependencies.confirmStoreInfoMerchant(branchInfo: branchInfo)
    }
    
    public static func sendRegisterFCMToken(registerDeviceInfo: APNSDeviceRegisterDTO) -> Promise<[String: Any]> {
        return moduleDependencies.sendRegisterFCMToken(registerDeviceInfo: registerDeviceInfo)
    }
    
    public static func createNewBranch(_ branchInfo: BranchInfoDTO) -> Promise<BranchInfoDTO> {
        return moduleDependencies.createNewBranch(branchInfo)
    }
    
    public static func getBeacon(_ beaconId: Int64) -> Promise<BeaconInfoDTO> {
        return moduleDependencies.getBeacon(beaconId)
    }
    
    public static func getBranchList(page: Int = 0, size: Int = 15, forSwitching: Bool) -> Promise<[String: Any]> {
        return moduleDependencies.getBranchList(page: page, size: size, forSwitching: forSwitching)
    }
     
    public static func updateBranchInfo(_ branchInfo: BranchInfoDTO) -> Promise<BranchInfoDTO> {
        return moduleDependencies.updateBranchInfo(branchInfo)
    }
     
    public static func switchBranch(_ branchId: Int64) -> Promise<[String: Any]> {
        return moduleDependencies.switchBranch(branchId)
    }
    
    public static func deleteBranchInfoPhotos(_ branchId: Int64, photos: [String]) -> Promise<BranchInfoDTO> {
        return moduleDependencies.deleteBranchInfoPhotos(branchId, photos: photos)
    }
    
    public static func getRetailerInfoForLauching() -> Promise<[String: Any]> {
        return moduleDependencies.getRetailerInfoForLauching()
    }
    
    public static func getBranchById(_ branchId: Int64) -> Promise<BranchInfoDTO> {
        return moduleDependencies.getBranchById(branchId)
    }
    
    public static func updateSalePerson(account: SalePersonDTO) -> Promise<SalePersonDTO> {
        return moduleDependencies.updateSalePerson(account: account)
    }
    
    public static func syncAddressFromBranchIntoBeacon(_ beaconId: Int64) -> Promise<BeaconInfoDTO> {
        return moduleDependencies.syncAddressFromBranchIntoBeacon(beaconId)
    }
    
    public static func syncLocationFromBranchIntoBeacon(_ beaconId: Int64) -> Promise<BeaconInfoDTO> {
        return moduleDependencies.syncLocationFromBranchIntoBeacon(beaconId)
    }
    
    public static func registerMoreBeacon(parameters: Any?) -> Promise<[String: Any]> {
        return moduleDependencies.registerMoreBeacon(parameters: parameters)
    }
}
