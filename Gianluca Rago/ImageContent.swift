//
//  ImageContent.swift
//  Gianluca Rago
//
//  Created by Gianluca Rago on 4/22/16.
//  Copyright © 2016 Gianluca. All rights reserved.
//

import UIKit

class ImageContent: UIImageView {
    
    init(frame:CGRect, img:UIImage, borderColor:UIColor) {
        super.init(frame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width*(img.size.height/img.size.width)))
        
        self.image = img
        self.userInteractionEnabled = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15.0
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = 3.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

}
