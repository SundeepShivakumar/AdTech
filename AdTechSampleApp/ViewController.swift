//
//  ViewController.swift
//  AdTechSampleApp
//
//  Created by Sundeep S on 23/11/20.
//  Copyright © 2020 Sundeep S. All rights reserved.
//

import UIKit
import AdTech

class ViewController: UIViewController {
    
    @IBOutlet weak var orgTextFiled: UITextField!
    @IBOutlet weak var contextidTextFiled: UITextField!
    @IBOutlet weak var AdView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdTechHelper.shared.configure()
        
        /* Test For Placement Context Lis
         
        let placementContext = PlacementContextList(id: "1", lob: "COMMON", pageName: "testpage", section: "testsection")
        
        AdTechHelper.shared.getAdWith(placementContextList: [placementContext], success: { (response) in
            if let view = response?.first {
                self.view.addSubview(view)
            }
        }) { (error) in
            print(error.errorMsg)
            print("Error in List")
        }
 
        */
    }
    @IBAction func getAd(_ sender: Any) {
        var placementContextId: PlacementContextIdList!
        
        if let id = self.contextidTextFiled.text {
            placementContextId = PlacementContextIdList(id:id)

        } else {
            placementContextId = PlacementContextIdList(id:"Q09NTU9OI1RFU1RQQUdFI1RFU1RTRUNUSU9OR0lG")
        }
        
        AdTechHelper.shared.getAdWith(placementContextIdList: [placementContextId], success: { (response) in
            if let view = response?.first {
                self.AdView.addAdTechSubview(view, stretchToFit: true)
            }
        }) { (error) in
            print(error.errorMsg)
            print("Error in ID")
        }
        
    }
}


// Img Context ID for Testing - Q09NTU9OI1RFU1RQQUdFI1RFU1RTRUNUSU9O
// GIF Context Id for Testing - Q09NTU9OI1RFU1RQQUdFI1RFU1RTRUNUSU9OR0lG
