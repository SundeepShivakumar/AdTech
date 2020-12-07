//
//  AdTechHelper.swift
//  AdTechSampleApp
//
//  Created by Sundeep S on 03/12/20.
//  Copyright © 2020 Sundeep S. All rights reserved.
//

import UIKit
import Foundation
import AdTech

public class AdTechHelper: NSObject {
    
    static let shared = AdTechHelper()
    
    private override init() {
        super.init()
    }
    
    func configure() {
        AdTechDependencyInjector.initializeDependency(adTechDelegate: self)
    }
    
    func getAdTechConfigModel() -> AdTechConfig {
        let config = AdTechConfig(authToken: "AuthToken", deviceID: "DeviceId")
        config.setOrg(with: .GI)
        return config
    }
    
    func getAdWith(placementContextList: [PlacementContextList], success:@escaping SuccessBlock, failure: @escaping FailureBlock) {
        AdTechManager().getAdWith(config: self.getAdTechConfigModel(), placementContextList: placementContextList, success: success, failure: failure)
    }
    
    func getAdWith(placementContextIdList: [PlacementContextIdList], success:@escaping SuccessBlock, failure: @escaping FailureBlock) {
        AdTechManager().getAdWith(config: self.getAdTechConfigModel(), placementContextIdList: placementContextIdList, success: success, failure: failure)
    }
    
    public func trackAdView(with data: AdTechResponse, resultBlock:@escaping trackResult) {
        AdTechManager().trackAdView(with: data, resultBlock: resultBlock)
    }
}


extension AdTechHelper: AdTechProtocol {
   
    public func showWebViewForAd(url: String) {
        print(" Please open Web View with URL \(url)")
    }
}

extension UIView {
    public func addAdTechSubview(_ subview: UIView, stretchToFit: Bool = false) {
        addSubview(subview)
        if stretchToFit {
            subview.translatesAutoresizingMaskIntoConstraints = false
            leftAnchor.constraint(equalTo: subview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: subview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: subview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: subview.bottomAnchor).isActive = true
        }
    }
}
