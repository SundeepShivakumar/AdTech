//
//  AdTechConfig.swift
//  AdTech
//
//  Created by Sundeep S on 24/11/20.
//  Copyright © 2020 Sundeep S. All rights reserved.
//

import Foundation

public enum Org: String {
    case MMT = "MMT"
    case GI = "GI"
}

public enum Region: String {
    case india = "IN"
}

public class AdTechConfig {
    var org: Org = .MMT
    var region: Region = .india
    var deviceId: String?
    var authToken: String?
    
    public init(authToken token:String, deviceID: String) {
        self.authToken = token
    }
    
    public func setOrg(with org:Org) {
        self.org = org
    }
    
    public func setRegion(with region:Region) {
        self.region = region
    }
    
}
