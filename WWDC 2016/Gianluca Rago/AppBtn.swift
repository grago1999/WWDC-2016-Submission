//
//  AppBtn.swift
//  Gianluca Rago
//
//  Created by Gianluca Rago on 4/25/16.
//  Copyright © 2016 Gianluca. All rights reserved.
//

import UIKit

class AppBtn: UIButton {
    
    var url:String
    
    init(frame:CGRect, withUrl:String) {
        url = withUrl
        super.init(frame:frame)
        
        self.addTarget(self, action:#selector(AppBtn.openUrl), forControlEvents:UIControlEvents.TouchUpInside)
    }
    
    func openUrl() {
        UIApplication.sharedApplication().openURL(NSURL(string:url)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        url = ""
        super.init(coder:aDecoder)
    }

}
