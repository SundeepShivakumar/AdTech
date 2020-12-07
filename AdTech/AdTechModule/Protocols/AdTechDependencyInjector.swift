//
//  AdTechDependencyInjector.swift
//  AdTech
//
//  Created by Sundeep S on 03/12/20.
//  Copyright © 2020 Sundeep S. All rights reserved.
//

import Foundation

public protocol AdTechProtocol : class {
    
    func showWebViewForAd(url:String)
}


public class AdTechDependencyInjector {
    internal static var adTechDelegate: AdTechProtocol?
    
    public static func initializeDependency(adTechDelegate:AdTechProtocol) {
        self.adTechDelegate = adTechDelegate
    }
}
