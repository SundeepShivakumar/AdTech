//
//  AdTechManager.swift
//  AdTech
//
//  Created by Sundeep S on 25/11/20.
//  Copyright © 2020 Sundeep S. All rights reserved.
//

import Foundation
import UIKit

public typealias SuccessBlock = ([AdTechView]?) -> Void
public typealias FailureBlock = (ErrorData) -> Void
public typealias trackResult = (Bool) -> Void

public class AdTechManager {
    
    var contextId: [String] = []
    
    public init() {
        
    }
    
    public func getAdWith(config: AdTechConfig, placementContextList: [PlacementContextList], success:@escaping SuccessBlock, failure:@escaping FailureBlock) {
        
        guard let url = URL(string:AdTechConstants.baseURL) else { return }
        
        for conext in placementContextList {
            self.contextId.append(conext.id)
        }
        
        //AdTechConstants.baseURL
        RestManager.sharedInstance.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        RestManager.sharedInstance.requestHttpHeaders.add(value: AdTechConstants.authorization, forKey: "authorization")
        RestManager.sharedInstance.requestHttpHeaders.add(value: config.org.rawValue, forKey: "org")
        RestManager.sharedInstance.requestHttpHeaders.add(value: config.region.rawValue, forKey: "region")
        RestManager.sharedInstance.requestHttpHeaders.add(value: AdTechConstants.usradid, forKey: "usradid")
        
        if let postData = self.getUserIdentifiers(with: config) {
            RestManager.sharedInstance.requestHttpHeaders.add(value: postData, forKey: "user-identifier")
        }
        
        if let postBoday = self.getPlacementCotext(with: placementContextList) {
            RestManager.sharedInstance.httpBodyParameters.add(value: postBoday, forKey: "placementContextList")
        }
        
        RestManager.sharedInstance.makeRequest(toURL: url, withHttpMethod: .POST) { (results) in
            guard let response = results.response else { return }
            
            if response.httpStatusCode == 200 {
                
                if let header =  response.headers.value(forKey: "Set-Cookie") {
                    let adck_id = header.split(separator: ";").filter { $0.contains("_adck_id")}.first
                    AdTechConstants.adck_id = String(adck_id ?? "")
                }
                
                guard let data = results.data else { return }
                
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let jsonObject = json as? [String:Any], let status = jsonObject["success"] as? Bool, status == true, let adResponse = jsonObject["data"] as? [String:Any] {
                    
                    var adTechResponses = [AdTechResponse]()
                    var error: String?
                    
                    for id in self.contextId {
                        if let jsonAd = adResponse[id] as? [String:Any] {
                            if jsonAd["error"] == nil {
                                let adTechresponse = AdTechResponse(dict: jsonAd)
                                adTechResponses.append(adTechresponse)
                            } else {
                                error = jsonAd["error"] as? String
                            }
                        }
                    }
                    
                    if adTechResponses.count > 0 {
                    DispatchQueue.main.async {
                        if let views = self.createView(with: adTechResponses) {
                            success(views)
                        }
                    }
                    } else {
                        failure(ErrorData(errorMsg: error ?? "Something went wrong, Please try again later.", errorCode: response.httpStatusCode))
                    }
                    
                    self.contextId = []
                }
            } else {
                self.contextId = []
                failure(ErrorData(errorMsg: results.error.debugDescription, errorCode: response.httpStatusCode))
            }
        }
    }
    
    public func getAdWith(config: AdTechConfig, placementContextIdList: [PlacementContextIdList], success:@escaping SuccessBlock, failure:@escaping FailureBlock) {
        
        guard let url = URL(string:AdTechConstants.baseURL) else { return }
        
        for conext in placementContextIdList {
            self.contextId.append(conext.contextId)
        }
        
        //AdTechConstants.baseURL
        RestManager.sharedInstance.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        RestManager.sharedInstance.requestHttpHeaders.add(value: AdTechConstants.authorization, forKey: "authorization")
        RestManager.sharedInstance.requestHttpHeaders.add(value: config.org.rawValue, forKey: "org")
        RestManager.sharedInstance.requestHttpHeaders.add(value: config.region.rawValue, forKey: "region")
        RestManager.sharedInstance.requestHttpHeaders.add(value: AdTechConstants.usradid, forKey: "usradid")
        
        if let postData = self.getUserIdentifiers(with: config) {
            RestManager.sharedInstance.requestHttpHeaders.add(value: postData, forKey: "user-identifier")
        }
        
        if let postBoday = self.getPlacementContextId(with: placementContextIdList) {
            RestManager.sharedInstance.httpBodyParameters.add(value: postBoday, forKey: "placementContextList")
        }
        
        RestManager.sharedInstance.makeRequest(toURL: url, withHttpMethod: .POST) { (results) in
            guard let response = results.response else { return }
            
            if response.httpStatusCode == 200 {
                
                if let header =  response.headers.value(forKey: "Set-Cookie") {
                    let adck_id = header.split(separator: ";").filter { $0.contains("_adck_id")}.first
                    AdTechConstants.adck_id = String(adck_id ?? "")
                }
                
                guard let data = results.data else { return }
                
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let jsonObject = json as? [String:Any], let status = jsonObject["success"] as? Bool, status == true, let adResponse = jsonObject["data"] as? [String:Any] {
                    
                    var adTechResponses = [AdTechResponse]()
                    
                    for id in self.contextId {
                        if let jsonAd = adResponse[id] as? [String:Any] {
                            let adTechresponse = AdTechResponse(dict: jsonAd)
                            adTechResponses.append(adTechresponse)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        if let views = self.createView(with: adTechResponses) {
                            success(views)
                        }
                    }
                    
                    self.contextId = []
                }
            } else {
                self.contextId = []
                failure(ErrorData(errorMsg: results.error.debugDescription, errorCode: response.httpStatusCode))
            }
        }
    }
    
    
    public func trackAdView(with data: AdTechResponse, resultBlock:@escaping trackResult) {
        guard data.adInfo?.trackingInfo?.viewTrackingReqd == true else { return }
        guard let url = URL(string:data.adInfo?.trackingInfo?.viewURL ?? "") else { return }
        
        RestManager.sharedInstance.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        RestManager.sharedInstance.requestHttpHeaders.add(value: AdTechConstants.authorization, forKey: "authorization")
        RestManager.sharedInstance.requestHttpHeaders.add(value: AdTechConstants.adck_id, forKey: "Cookie")
        
        RestManager.sharedInstance.makeRequest(toURL: url, withHttpMethod: .GET) { (result) in
            guard let response = result.response else { return }
            
            if response.httpStatusCode == 200 {
                guard let data = result.data else { return }
                
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let jsonObject = json as? [String:Any], let status = jsonObject["success"] as? Bool, status == true {
                    resultBlock(true)
                } else {
                    resultBlock(false)
                }
            } else {
                resultBlock(false)
            }
        }
        
    }
    
    internal func trackAdClick(with data: AdTechResponse, resultBlock:@escaping trackResult) {
        guard data.adInfo?.trackingInfo?.clickTrackingReqd == true else { return }
        guard let url = URL(string:data.adInfo?.trackingInfo?.clickURL ?? "") else { return }
        
        
        RestManager.sharedInstance.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        RestManager.sharedInstance.requestHttpHeaders.add(value: AdTechConstants.authorization, forKey: "authorization")
        RestManager.sharedInstance.requestHttpHeaders.add(value: AdTechConstants.adck_id, forKey: "Cookie")
        
        RestManager.sharedInstance.makeRequest(toURL: url, withHttpMethod: .GET) { (result) in
            guard let response = result.response else { return }
            
            if response.httpStatusCode == 200 {
                guard let data = result.data else { return }
                
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let jsonObject = json as? [String:Any], let status = jsonObject["success"] as? Bool, status == true {
                    resultBlock(true)
                } else {
                    resultBlock(false)
                }
            } else {
                resultBlock(false)
            }
        }
    }
}


extension AdTechManager {
    
    fileprivate func getUserIdentifiers(with config: AdTechConfig) -> String? {
        let userIdentifiers = ["type":"auth","deviceId":config.deviceId,"os":"IOS","osVersion":UIDevice.current.systemVersion,"value":config.authToken]
        
        if let postData = (try? JSONSerialization.data(withJSONObject: userIdentifiers, options: JSONSerialization.WritingOptions())) {
            return String(data: postData, encoding: String.Encoding.utf8)
        }
        
        return nil
    }
    
    fileprivate func getPlacementCotext(with contextList: [PlacementContextList]) -> [[String:String]]? {
        var placementContextList = [[String:String]]()
        
        for context in contextList {
            placementContextList.append(context.getDictFormat())
        }
        
        return placementContextList
    }
    
    fileprivate func getPlacementContextId(with list: [PlacementContextIdList]) -> [[String:String]]? {
        var placementContextList = [[String:String]]()
        
        for context in list {
            placementContextList.append(context.getDictFormat())
        }
        
        return placementContextList
    }
}


extension AdTechManager {
    
    internal func createView(with data:[AdTechResponse]) -> [AdTechView]? {
        var adTechImageViewArray = [AdTechView]()
        
        for context in data {
            if let adTechImageView = instanceFromNib() {
                adTechImageView.configureView(with: context)
                adTechImageViewArray.append(adTechImageView)
            }
        }
        return adTechImageViewArray
    }
    
    
    func instanceFromNib() -> AdTechView? {
        let bundle = Bundle(for: type(of: self))
        let nibName = "AdTechView"
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: nil, options: nil).first as? AdTechView
        return view
    }
}
