//
//  CompleteController.swift
//  Gianluca Rago
//
//  Created by Gianluca Rago on 4/23/16.
//  Copyright © 2016 Gianluca. All rights reserved.
//

import UIKit

class CompleteController: UIViewController {
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:81.0/255.0, green:124.0/255.0, blue:236.0/255.0, alpha:1.0)
    }
    
    override func viewDidAppear(animated: Bool) {
        let thanksLabel = LabelContent(frame:CGRectMake(0, 0, screenWidth/1.15, 150.0), str:"Thanks for learning about me.", textColor:UIColor.whiteColor())
        thanksLabel.center = CGPointMake(screenWidth/2, screenHeight*(2/5))
        thanksLabel.alpha = 0
        self.view.addSubview(thanksLabel)
        
        let seeLabel = LabelContent(frame:CGRectMake(0, 0, screenWidth/1.15, 150.0), str:"I hope to see you at WWDC!", textColor:UIColor.whiteColor())
        seeLabel.center = CGPointMake(screenWidth/2, screenHeight*(3/5))
        seeLabel.alpha = 0
        self.view.addSubview(seeLabel)
        
        let nameLabel = LabelContent(frame:CGRectMake(0, screenHeight-70.0, screenWidth, 70.0), str:"Gianluca ", textColor:UIColor.whiteColor())
        nameLabel.alpha = 0
        self.view.addSubview(nameLabel)
        
        let animDuration = 1.5
        UIView.animateWithDuration(animDuration, animations: {
            thanksLabel.alpha = 1
        }, completion: { finished in
            UIView.animateWithDuration(animDuration, animations: {
                seeLabel.alpha = 1
            }, completion: { finished in
                UIView.animateWithDuration(animDuration, animations: {
                    nameLabel.alpha = 1
                }, completion: { finished in
                    
                })
            })
        })
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
