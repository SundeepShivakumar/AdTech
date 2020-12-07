//
//  AdTechImageView.swift
//  AdTech
//
//  Created by Sundeep S on 25/11/20.
//  Copyright © 2020 Sundeep S. All rights reserved.
//

import UIKit
import Photos

public class AdTechView: UIView {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var adImgView: UIImageView!
    
    public var adTechResponse: AdTechResponse?
    
    internal func configureView(with data: AdTechResponse) {
        self.adTechResponse = data
        
        let width = Float(data.adInfo?.width ?? "0") ?? 0
        let height = Float(data.adInfo?.height ?? "0") ?? 0
        
        self.frame = CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height))
        //self.loadImage(with: data.adInfo?.contentURL ?? "")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(adClick))
        self.containerView.addGestureRecognizer(tapGesture)
        
        if self.adTechResponse?.adInfo?.adType == .img {
            self.loadImage(with: self.adTechResponse?.adInfo?.contentURL ?? "")
        }
    }
    
    internal func loadImage(with url:String) {
        adImgView.loadImageFromUrl(urlString: url)
    }
    
    @objc public func adClick() {
        guard let redirectUrl = self.adTechResponse?.adInfo?.redirectURL else { return }
        AdTechDependencyInjector.adTechDelegate?.showWebViewForAd(url: redirectUrl)
    }
}
