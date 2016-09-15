//
//  TextContent.swift
//  Gianluca Rago
//
//  Created by Gianluca Rago on 4/22/16.
//  Copyright © 2016 Gianluca. All rights reserved.
//

import UIKit

class TextContent: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame:frame, textContainer:textContainer)
        
        self.backgroundColor = UIColor.clearColor()
        self.textColor = UIColor.blackColor()
        self.font = UIFont(name:"Avenir", size:20.0)
        self.textAlignment = .Center
        self.scrollEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

}
