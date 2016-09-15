//
//  CircleView.swift
//  Gianluca Rago
//
//  Created by Gianluca Rago on 4/20/16.
//  Copyright © 2016 Gianluca. All rights reserved.
//

import UIKit

class CircleView: UIButton {
    
    var vc:ViewController?
    var hasBeenViewed = false
    
    init(frame:CGRect, img:UIImage) {
        super.init(frame:frame)
        
        self.setImage(img, forState:.Normal)
        self.addTarget(self, action:#selector(CircleView.viewContent), forControlEvents:UIControlEvents.TouchUpInside)
        self.backgroundColor = UIColor.whiteColor()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    func viewContent() {
        let contentController = ContentController()
        contentController.setup(self.tag)
        vc?.lastSelectedTag = self.tag
        vc?.presentViewController(contentController, animated:true, completion:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

}
