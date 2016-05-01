//
//  LabelContent
//  Gianluca Rago
//
//  Created by Gianluca Rago on 4/23/16.
//  Copyright © 2016 Gianluca. All rights reserved.
//

import UIKit

class LabelContent: UILabel {

    init(frame:CGRect, str:String, textColor:UIColor) {
        super.init(frame:frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.text = str
        self.textColor = textColor
        self.font = UIFont(name:"Avenir-Heavy", size:24.0)
        self.textAlignment = .Center
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

}
