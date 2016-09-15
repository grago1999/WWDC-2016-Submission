//
//  ViewController.swift
//  Gianluca Rago
//
//  Created by Gianluca Rago on 4/20/16.
//  Copyright © 2016 Gianluca. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerPreviewingDelegate {
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    var circleViews:[CircleView] = []
    var mainCircleView:CircleView?
    var lines:[UIBezierPath] = []
    var circleViewsContainer = UIView()
    var hasSelectedContent = false
    var lastSelectedTag = 0
    var hasShownComplete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleViewsContainer = UIView(frame:CGRectMake(0, 0, screenWidth, screenHeight))
        circleViewsContainer.backgroundColor = UIColor.clearColor()
        self.view.addSubview(circleViewsContainer)
        
        mainCircleView = CircleView(frame:CGRectMake(0, 0, 80.0, 80.0), img:UIImage(named:"me.jpg")!)
        mainCircleView!.center = self.view.center
        mainCircleView!.layer.zPosition = 2
        mainCircleView!.vc = self
        mainCircleView!.tag = 0
        if traitCollection.forceTouchCapability == .Available {
            registerForPreviewingWithDelegate(self, sourceView:mainCircleView!)
        }
        circleViewsContainer.addSubview(mainCircleView!)
    }
    
    override func viewDidAppear(animated: Bool) {
        if hasSelectedContent {
            var animDuration = 0.5
            var tempCircleViews = self.circleViews
            tempCircleViews.append(self.mainCircleView!)
            for circleView in tempCircleViews {
                if circleView.tag == lastSelectedTag {
                    circleView.hasBeenViewed = true
                    UIView.animateWithDuration(animDuration, animations: {
                        circleView.center = self.view.center
                    }, completion: { finsihed in
                        circleView.userInteractionEnabled = false
                        var shouldComplete = true
                        for circleView in tempCircleViews {
                            if !circleView.hasBeenViewed {
                                shouldComplete = false
                                break
                            }
                        }
                        
                        if shouldComplete && !self.hasShownComplete {
                            animDuration = 0.625
                            
                            let transitionView = UIView(frame:CGRectZero)
                            transitionView.center = self.view.center
                            transitionView.backgroundColor = UIColor(red:81.0/255.0, green:124.0/255.0, blue:236.0/255.0, alpha:1.0)
                            transitionView.layer.zPosition = 3
                            self.view.addSubview(transitionView)
                            
                            CATransaction.begin()
                            let cornerAnim = CABasicAnimation(keyPath:"cornerRadius")
                            cornerAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
                            cornerAnim.fromValue = NSNumber(float:0.0)
                            cornerAnim.toValue = NSNumber(float:Float(self.screenHeight))
                            cornerAnim.duration = animDuration
                            
                            let boundsAnim = CABasicAnimation(keyPath:"bounds")
                            boundsAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
                            boundsAnim.fromValue = NSValue(CGRect:transitionView.frame)
                            boundsAnim.toValue = NSValue(CGRect:CGRectMake(0, 0, self.screenHeight*2, self.screenHeight*2))
                            boundsAnim.duration = animDuration
                            boundsAnim.fillMode = kCAFillModeBoth
                            boundsAnim.removedOnCompletion = false
                            
                            transitionView.layer.addAnimation(boundsAnim, forKey:"bounds")
                            transitionView.layer.addAnimation(cornerAnim, forKey:"cornerRadius")
                            CATransaction.commit()
                            
                            self.hasShownComplete = true
                            
                            let delay = animDuration*Double(NSEC_PER_SEC)
                            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                            
                            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                                let completeController = CompleteController()
                                self.presentViewController(completeController, animated:false, completion:nil)
                            })
                        }
                    })
                    drawLine(circleView.tag-1, animDuration:animDuration, lineColor:UIColor.whiteColor(), lineWidth:6.0, fromPoint:getCirclePoint(circleView.tag-1), toPoint:self.view.center)
                    break
                }
            }
        } else {
            startCircleViews()
        }
    }
    
    func resetCircleViews() {
        let animDuration = 0.5
        for circleView in circleViews {
            UIView.animateWithDuration(animDuration, animations: {
                circleView.center = self.view.center
            }, completion: { finished in
                circleView.removeFromSuperview()
            })
            drawLine(circleView.tag-1, animDuration:animDuration, lineColor:UIColor.whiteColor(), lineWidth:6.0, fromPoint:getCirclePoint(circleView.tag-1), toPoint:self.view.center)
        }
        circleViews.removeAll()
        hasSelectedContent = false
        lastSelectedTag = 0
        
        let delay = (animDuration/2)*Double(NSEC_PER_SEC)
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.startCircleViews()
        })
    }
    
    func startCircleViews() {
        let initialDelay = 0.5*Double(NSEC_PER_SEC)
        let initialDispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(initialDelay))
        
        dispatch_after(initialDispatchTime, dispatch_get_main_queue(), {
            let imgDict:[Int:String] = [0 : "regis.jpg", 1 : "swift.png", 2 :"appStore.png", 3 : "steam.png", 4 : "wwdc.png", 5 : "hackbca.png"]
            for i in 0...5 {
                let img:UIImage = UIImage(named:imgDict[i]!)!
                let circleView = CircleView(frame:CGRectMake(0, 0, 60.0, 60.0), img:img)
                circleView.center = self.view.center
                circleView.vc = self
                circleView.tag = i+1
                if self.traitCollection.forceTouchCapability == .Available {
                    self.registerForPreviewingWithDelegate(self, sourceView:circleView)
                }
                
                let animDelay = (Double(i)/8.0)*Double(NSEC_PER_SEC)
                let animDispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(animDelay))
                
                dispatch_after(animDispatchTime, dispatch_get_main_queue(), {
                    let animDuration = 0.5
                    self.drawLine(i, animDuration:animDuration, lineColor:UIColor.blackColor(), lineWidth:3.0, fromPoint:self.view.center, toPoint:self.getCirclePoint(i))
                    
                    UIView.animateWithDuration(animDuration, animations: {
                        circleView.center = self.getCirclePoint(i)
                        }, completion: { finished in
                            if i == 5 {
                                self.circleViewsContainer.rotate()
                            }
                    })
                    self.circleViewsContainer.addSubview(circleView)
                    self.circleViews.append(circleView)
                })
            }
        })
    }
    
    func drawLine(i:Int, animDuration:Double, lineColor:UIColor, lineWidth:CGFloat, fromPoint:CGPoint, toPoint:CGPoint) {
        let path:UIBezierPath = UIBezierPath()
        path.moveToPoint(fromPoint)
        path.addLineToPoint(toPoint)
        lines.append(path)
        
        let pathLayer:CAShapeLayer = CAShapeLayer()
        pathLayer.frame = self.view.bounds
        pathLayer.path = path.CGPath
        pathLayer.strokeColor = lineColor.CGColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = lineWidth
        pathLayer.lineJoin = kCALineJoinBevel
        pathLayer.zPosition = -1
        circleViewsContainer.layer.addSublayer(pathLayer)
        path.drawLineWithAnim(animDuration, toLayer:pathLayer)
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        self.presentViewController(viewControllerToCommit, animated:false, completion:nil)
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        var tag = 0
        for circleView in circleViews {
            if circleView.frame == previewingContext.sourceView.frame {
                tag = circleView.tag
                break
            }
        }
        let contentController = ContentController()
        contentController.setup(tag)
        lastSelectedTag = tag
        return contentController
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            resetCircleViews()
        }
    }
    
    func getCirclePoint(i:Int) -> CGPoint {
        let radius = 135.0
        let angle:Double = Double(i+1)*(60.0*(M_PI/180.0))
        let x = cos(angle)*radius
        let y = sin(angle)*radius
        return CGPointMake(CGFloat(x)+self.view.center.x, CGFloat(y)+self.view.center.y)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.hasSelectedContent = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension UIBezierPath {
    
    func drawLineWithAnim(animDuration:Double, toLayer:CAShapeLayer) {
        let pathAnimation:CABasicAnimation = CABasicAnimation(keyPath:"strokeEnd")
        pathAnimation.duration = animDuration
        pathAnimation.fromValue = NSNumber(float:0.0)
        pathAnimation.toValue = NSNumber(float:1.0)
        toLayer.addAnimation(pathAnimation, forKey:"strokeEnd")
    }
    
}

extension UIView {
    
    func rotate() {
        let rotation = CABasicAnimation(keyPath:"transform.rotation")
        rotation.fromValue = 0.0
        rotation.toValue = CGFloat(M_PI*2.0)
        rotation.duration = 0.8
        rotation.repeatCount = 1
        rotation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.layer.addAnimation(rotation, forKey:nil)
    }
    
}