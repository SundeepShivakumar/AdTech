//
//  AdTechModels.swift
//  AdTech
//
//  Created by Sundeep S on 23/11/20.
//  Copyright © 2020 Sundeep S. All rights reserved.
//

import Foundation

internal struct AdTechConstants {
    internal static let authorization: String = "DFjgkXbgFGBvebc"
    internal static let baseURL: String = "https://adorch.goibibo.com/ext/user/serve/ad"
    internal static var usradid: String = ""
    internal static var adck_id: String = ""
}

public struct ErrorData {
    public var errorMsg: String = ""
    public var errorCode: Int = 404
}


public struct PlacementContextList {
    var id: String = ""
    var lob: String = ""
    var pageName: String = ""
    var section: String = ""
    
    public init(id:String, lob:String, pageName:String, section:String) {
        self.id = id
        self.lob = lob
        self.pageName = pageName
        self.section = section
    }
    
    internal func getDictFormat() -> [String: String] { 
        
        return ["id" : id, "lob" : lob, "pageName" : pageName, "section" : section]
    }
}

public struct PlacementContextIdList {
    var contextId: String = ""
    
    public init(id: String) {
        self.contextId = id
    }
    
    internal func getDictFormat() -> [String: String] {
        return ["contextId":contextId]
    }
}

public enum AdType: String, Codable {
    case img = "IMG"
    case gif = "Gif"
}


public class AdTechResponse {
    var keywords: [String]?
    var lob: String?
    var pageName:String?
    var section:String?
    var useClientSdk:Bool = false
    var adInfo: AdInfo?
    
    init(dict: [String:Any]) {
        
        if let keywords = dict["keywords"] as? [String] {
            self.keywords = keywords
        }
        
        if let lob = dict["lob"] as? String {
            self.lob = lob
        }
        
        if let pageName = dict["pageName"] as? String {
            self.pageName = pageName
        }
        
        if let section = dict["section"] as? String {
            self.section = section
        }
        
        if let useClientSdk = dict["useClientSdk"] as? Bool {
            self.useClientSdk = useClientSdk
        }
        
        if let adInfo = dict["jsonAd"] as? [String:Any] {
            self.adInfo = AdInfo(dict: adInfo)
        }
    }
    
}

public class AdInfo {
    var adType: AdType = .img
    var bannerId: String?
    var width:String?
    var height:String?
    var altText:String?
    var accompaniedHtml:String?
    var target:String?
    var trackingPixel: String?
    var body:String?
    var redirectURL:String?
    var refreshURL: String?
    var refreshTime:String?
    var contentURL: String?
    var adTrackId: String?
    var trackingReqd: Bool = false
    var trackingInfo: TrackingInfo?
    var advertiserInfo: AdvertiserInfo?
    
    init(dict:[String:Any]) {
        
        if let adType = dict["adType"] as? String {
            self.adType = AdType(rawValue: adType) ?? .img
        }
        
        if let bannerId = dict["banner_id"] as? String {
            self.bannerId = bannerId
        }
        
        if let width = dict["width"] as? String {
            self.width = width
        }
        
        if let height = dict["height"] as? String {
            self.height = height
        }
        
        if let altText = dict["alt_text"] as? String {
            self.altText = altText
        }
        
        if let accompaniedHtml = dict["accompanied_html"] as? String {
            self.accompaniedHtml = accompaniedHtml
        }
        
        if let target = dict["target"] as? String {
            self.target = target
        }
        
        if let trackingPixel = dict["tracking_pixel"] as? String {
            self.trackingPixel = trackingPixel
        }
        
        if let body = dict["body"] as? String {
            self.body = body
        }
        
        if let redirectURL = dict["redirect_url"] as? String {
            self.redirectURL = redirectURL
        }
        
        if let refreshURL = dict["refresh_url"] as? String {
            self.refreshURL = refreshURL
        }
        
        if let refreshTime = dict["refresh_time"] as? String {
            self.refreshTime = refreshTime
        }
        
        if let contentURL = dict["content_url"] as? String {
            self.contentURL = contentURL
        }
        
        if let adTrackId = dict["ad_track_id"] as? String {
            self.adTrackId = adTrackId
        }
        
        if let trackingReqd = dict["tracking_reqd"] as? Bool {
            self.trackingReqd = trackingReqd
        }
        
        if let trackingNode = dict["tracking_node"] as? [String:Any] {
            self.trackingInfo = TrackingInfo(dict: trackingNode)
        }
        
        if let tracking = dict["tracking"] as? [String:Any], let advertiserInfo = tracking["advertiser"] as? [String:Any] {
            self.advertiserInfo = AdvertiserInfo(dict: advertiserInfo)
        }
        
    }
    
}

public class TrackingInfo {
    var clickURL:String?
    var viewURL: String?
    var viewTrackingReqd: Bool = false
    var clickTrackingReqd: Bool = false
    
    init(dict:[String:Any]) {
        
        if let clickURL = dict["click_url"] as? String {
            self.clickURL = clickURL
        }
        
        if let viewURL = dict["advertiser_id"] as? String {
            self.viewURL = viewURL
        }
        
        if let viewTrackingReqd = dict["view_tracking_reqd"] as? Bool {
            self.viewTrackingReqd = viewTrackingReqd
        }
        
        if let clickTrackingReqd = dict["click_tracking_reqd"] as? Bool {
            self.clickTrackingReqd = clickTrackingReqd
        }
        
    }
}

public class AdvertiserInfo {
    var advertiserId: String?
    var campaignId: String?
    var advertisementId: String?
    
    init(dict:[String:Any]) {
        
        if let advertiserId = dict["advertiser_id"] as? String {
            self.advertiserId = advertiserId
        }
        
        if let campaignId = dict["campaign_id"] as? String {
            self.campaignId = campaignId
        }
        
        if let advertisementId = dict["advertisement_id"] as? String {
            self.advertisementId = advertisementId
        }
        
    }
}







