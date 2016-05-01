//
//  ContentController.swift
//  Gianluca Rago
//
//  Created by Gianluca Rago on 4/20/16.
//  Copyright © 2016 Gianluca. All rights reserved.
//

import UIKit

class ContentController: UIViewController {
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    var tag:Int = 0
    let margin:CGFloat = 40.0
    
    var navBar:NavBar?
    var contentScroll:UIScrollView?
    
    var textDict:[Int:[String]] = [0 : ["Hello! My name is Gianluca Rago and I am a 17 year old student from Staten Island, New York.", "I hope you enjoy learning all about me!"], 1 : ["I am a Junior at Regis High School in Manhattan, New York.", "I recently began teaching iOS development using Swift to my school's Computer Club. I even have all the materials on Github!"], 2 : ["Within the last year, I began worknig with new languages including SQL and C++.", " I am currently working on two projects that take make use of SQL, PHP, HTML, CSS, and Swift all working together for native web and iOS applications.", "You can even find this entire project on Github! (grago1999)"], 3 : ["I built my first app in the 8th grade called Gemini, an easy to use split screen multitasking app. I recently redesigned the app using a hybrid of iOS and material design techniques.", "Looking Glass allows users to browse the web while still being able to see where they walk. It uses the back camera to display what is in front of the user while he or she can still interact with the device.", "My first app using Swift was a game called Helicopter Havoc. The art was inspired by older games that I still enjoy playing.", "Conjungo is one of my newest projects, and easily my most advanced. I created a backend server using MySQL and PHP to handle the bulk of the application, in addition to the client side iOS and Web apps. I am currently working on a massive update on the entire application that will be released shorty."], 4 : ["I have been playing video games for as long as I can remember.", "Minecraft, which is one of my favorite games, inspired me to learn how to program. I remember beginning to learn basic Javascript for a few weeks, only to learn that the game was built in Java, not Javascript!", "And with this misstep, I was immersed into the world of computer technology."], 5 : ["I was honored to attend WWDC in 2014 and 2015.", "I had some of the greatest experiences getting to meet other people as interested in technology as I am.", "I even got this great picture!", "Hopefully I will see you there this year!"], 6 : ["Since last year, I attended two more hackathons, and I am planning on attending another one in the coming weeks!", "I am even considering working with friends to start my own!"]]
    var imgDict:[Int:[String]] = [0 : ["me.jpg"], 1 : ["school1.jpg"], 2 : ["cPlusPlus.png", "this.png"], 3 : ["gemini.png", "lookingGlass.png", "heliHavoc.jpg", "conjungo.png"], 4 : ["steam2.jpg", "minecraft.jpg"], 5 : ["WWDC1.jpg", "WWDC2.jpg", "WWDC3.jpg"], 6 : ["hackbca.png"]]
    var colorDict:[Int:UIColor] = [0 : UIColor(red:63.0/255.0, green:81.0/255.0, blue:181.0/255.0, alpha:1.0), 1 : UIColor(red:180.0/255.0, green:3.0/255.0, blue:25.0/255.0, alpha:1.0), 2 : UIColor(red:255.0/255.0, green:79.0/255.0, blue:38.0/255.0, alpha:1.0), 3 : UIColor(red:81.0/255.0, green:124.0/255.0, blue:236.0/255.0, alpha:1.0), 4 : UIColor(red:81.0/255.0, green:101.0/255.0, blue:153.0/255.0, alpha:1.0), 5 : UIColor(red:114.0/255.0, green:51.0/255.0, blue:48.0/255.0, alpha:1.0), 6 : UIColor(red:63.0/255.0, green:81.0/255.0, blue:181.0/255.0, alpha:1.0)]
    var titleDict:[Int:String] = [0 : "Me", 1 : "Education", 2 : "Programming", 3 : "Software", 4 : "Video Games", 5 : "WWDC", 6 : "Tech"]
    var appDict:[Int:String] = [0 : "https://itunes.apple.com/us/app/gemini-do-two-things-at-once!/id1091442701?ls=1&mt=8", 1 : "https://itunes.apple.com/us/app/looking-glass-see-ahead-your/id797890079?ls=1&mt=8", 2 : "https://itunes.apple.com/us/app/helicopter-havoc/id957157286?ls=1&mt=8", 3 : "https://itunes.apple.com/us/app/conjungo/id1035170340?ls=1&mt=8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    func setup(withTag:Int) {
        tag = withTag
        contentScroll = UIScrollView(frame:CGRectMake(0, 0, screenWidth, screenHeight))
        contentScroll?.contentSize = CGSizeMake(screenWidth, screenHeight)
        self.view.addSubview(contentScroll!)
        
        var lastY:CGFloat = 60.0+margin
        let texts = textDict[tag]
        let imgs = imgDict[tag]
        for i in 0...Int((texts?.count)!-1) {
            let textContent = TextContent(frame:CGRectMake(margin, lastY, screenWidth-(2*margin), 200.0))
            textContent.text = texts![i]
            textContent.sizeToFit()
            textContent.layoutIfNeeded()
            textContent.frame = CGRectMake(textContent.frame.origin.x, textContent.frame.origin.y, screenWidth-(2*margin), textContent.frame.size.height)
            contentScroll?.addSubview(textContent)
            
            if i <= (imgs?.count)!-1 {
                let imgContent = ImageContent(frame:CGRectMake(margin, textContent.frame.origin.y+textContent.frame.size.height+margin, screenWidth-(2*margin), screenWidth-(2*margin)), img:UIImage(named:imgs![i])!, borderColor:colorDict[tag]!)
                contentScroll?.addSubview(imgContent)
                lastY = imgContent.frame.origin.y+imgContent.frame.size.height+margin
                
                if tag == 3 {
                    let appBtn = AppBtn(frame:CGRectMake(0, 0, imgContent.frame.size.width, imgContent.frame.size.height), withUrl:appDict[i]!)
                    imgContent.addSubview(appBtn)
                }
            } else {
                lastY = textContent.frame.origin.y+textContent.frame.size.height+margin
            }
            if lastY >  contentScroll?.contentSize.height {
                contentScroll?.contentSize = CGSizeMake(screenWidth, lastY)
            }
        }
        
        navBar = NavBar(frame:CGRectMake(0, 0, screenWidth, 60.0), btnColor:colorDict[tag]!, title:titleDict[tag]!)
        navBar!.vc = self
        self.view.addSubview(navBar!)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
