
//
//  NavBar.swift
//  Gianluca Rago
//
//  Created by Gianluca Rago on 4/22/16.
//  Copyright © 2016 Gianluca. All rights reserved.
//

import UIKit

class NavBar: UIView {
    
    var vc:UIViewController?
    
    init(frame:CGRect, btnColor:UIColor, title:String) {
        super.init(frame:frame)
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.zPosition = 2
        
        let returnBtn = UIButton(frame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height))
        returnBtn.setImage(UIImage(named:"back.png")?.imageWithRenderingMode(.AlwaysTemplate), forState:.Normal)
        returnBtn.tintColor = btnColor
        returnBtn.addTarget(self, action:#selector(NavBar.returnToMain), forControlEvents:.TouchUpInside)
        self.addSubview(returnBtn)
        
        let labelContent = LabelContent(frame:CGRectMake(0, 0, self.frame.size.width*(2/3), self.frame.size.height), str:title, textColor:btnColor)
        labelContent.center = CGPointMake(self.frame.size.width/2, labelContent.center.y)
        self.addSubview(labelContent)
    }
    
    func returnToMain() {
        vc?.dismissViewControllerAnimated(true, completion:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

}
