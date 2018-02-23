//
//  StickersVC.swift
//  Filtering
//
//  Created by Polak on 5/30/17.
//  Copyright © 2017 Polak. All rights reserved.
//

import UIKit
import AVFoundation

protocol StickerDelegate:class {
    func stickerDidFinish(_ stickerVC:StickersVC)
}


class StickersVC: UIViewController,UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var centerScrollView: UIScrollView!
    
    @IBOutlet weak var contentView : UIView!
    
    @IBOutlet weak var backImageView : UIImageView!
    
    @IBOutlet weak var frontImageView : UIImageView!
    
    @IBOutlet weak var toolsScrollView: UIScrollView!
    @IBOutlet weak var subToolsScrollView: UIScrollView!
    
    @IBOutlet weak var subToolsView: UIView!
    @IBOutlet weak var subToolsLabel: UILabel!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    
    
    var image:UIImage?
    var  gettag:Int!
    
    var stickerDelegate:StickerDelegate?
    var imageFromStickerVC : UIImage?
    
 var stickersImageArray = ["st1","st2","st3","st4","st5","st6","st7","st8","st9","st10","st11","st12","st13","st14","st15","st16","st17","st18","st19","st20","st21","st22","st23","st24","st25","st26","st27","st28","st29","st30","st31","st32","st33","st34","st35","st36","st37","st38","st39","st40","st41","st42","st43","st44","st45","st46","st47","st48","st49","st50","st51","st52","st53","st54","st55"]

    override func viewDidLoad() {
        super.viewDidLoad()
        gettag=100
        
        self.subToolsLabel.text = "Stickers"
        // Do any additional setup after loading the view.
        
        backImageView.frame = AVMakeRect(aspectRatio: (image?.size)!, insideRect: backImageView.bounds)
        backImageView.image = image
        
        frontImageView.frame = AVMakeRect(aspectRatio: (image?.size)!, insideRect: frontImageView.bounds)
        frontImageView.image = image
        
        
        stickerScrollCreation()
        self.sliderOutlet.isHidden = true
        

        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    var stickersitemCount = 0
    func stickerScrollCreation() {
        
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 50.0
        let buttonHeight: CGFloat = 50.0
        let gapBetweenButtons: CGFloat = 5
        
        
        for i in 0..<stickersImageArray.count{
            stickersitemCount = i
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = stickersitemCount
            filterButton.showsTouchWhenHighlighted = true
            filterButton.contentMode = .scaleAspectFill
            
            let myimage = UIImage(named: stickersImageArray[stickersitemCount])
            filterButton.setImage(myimage, for: .normal)
            
            filterButton.addTarget(self, action:#selector(stickersButtonTapped), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            xCoord +=  buttonWidth + gapBetweenButtons
            subToolsScrollView.addSubview(filterButton)
        }
        
        subToolsScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(stickersitemCount+6), height: yCoord)
        
    }
    
    
    var stickerImageView = UIImageView()
    func stickersButtonTapped(sender: UIButton) {
        
       
        
        let button = sender as UIButton
        
        
        
        switch button.tag {
            
        case 0:
            let imageName = "st1"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 1:
            let imageName = "st2"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 2:
            let imageName = "st3"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
            
        case 3:
            
            let imageName = "st4"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 4:
            
            let imageName = "st5"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 5:
            let imageName = "st6"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 6:
            
            let imageName = "st7"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 7:
            
            let imageName = "st8"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 8:
            
            let imageName = "st9"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 9:
            
            let imageName = "st10"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 10:
            
            let imageName = "st11"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 11:
            
            let imageName = "st12"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
        case 12:
            
            let imageName = "st13"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 13:
            
            let imageName = "st14"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 14:
            
            let imageName = "st15"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 15:
            
            let imageName = "st16"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 16:
            
            let imageName = "st17"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 17:
            
            let imageName = "st18"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 18:
            
            let imageName = "st19"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 19:
            
            let imageName = "st20"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 20:
            
            let imageName = "st21"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 21:
            let imageName = "st22"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 22:
            
            let imageName = "st23"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 23:
            
            let imageName = "st24"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 24:
            
            let imageName = "st25"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 25:
            
            let imageName = "st26"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 26:
            let imageName = "st27"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 27:
            let imageName = "st28"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 28:
            
            let imageName = "st29"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 29:
            
            let imageName = "st30"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 30:
            
            let imageName = "st31"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 31:
            
            let imageName = "st32"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 32:
            
            let imageName = "st33"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 33:
            
            let imageName = "st34"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 34:
            
            let imageName = "st35"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 35:
            
            let imageName = "st36"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 36:
            
            let imageName = "st37"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 37:
            
            let imageName = "st38"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 38:
            
            let imageName = "st39"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 39:
            
            let imageName = "st40"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 40:
            
            let imageName = "st41"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 41:
            
            let imageName = "st42"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 42:
            
            let imageName = "st43"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 43:
            
            let imageName = "st44"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 44:
            
            let imageName = "st45"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 45:
            
            let imageName = "st46"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 46:
            
            let imageName = "st47"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 47:
            
            let imageName = "st48"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 48:
            
            let imageName = "st49"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 49:
            
            let imageName = "st50"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 50:
            
            let imageName = "st51"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 51:
            
            let imageName = "st52"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 52:
            
            let imageName = "st53"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 53:
            
            let imageName = "st54"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
            
        case 54:
            
            let imageName = "st55"
            let image = UIImage(named: imageName)
            stickerImageView = UIImageView(image: image!)
      
        default:
            
            self.imageFromStickerVC = self.returnFinalImage()
  
        }
        
        UIView.transition(with: sliderOutlet, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
            self.sliderOutlet.isHidden = false
        }, completion: { _ in })
        
        
        
        stickerImageView.frame = CGRect(x: 20, y: 50, width: 130, height: 130)
        stickerImageView.isUserInteractionEnabled = true
        
        stickerImageView.tag=gettag
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(self.rotateGesture))
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        
        stickerImageView.addGestureRecognizer(panGesture)
        stickerImageView.addGestureRecognizer(pinchGesture)
        stickerImageView.addGestureRecognizer(rotateGesture)
        stickerImageView.addGestureRecognizer(tapgesture)
        frontImageView.addSubview(stickerImageView)
        gettag=gettag+1
        
        self.imageFromStickerVC = self.returnFinalImage()
        

    }
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        
        DispatchQueue.main.async
            {
                self.stickerImageView.alpha = CGFloat(sender.value)
                self.imageFromStickerVC = self.returnFinalImage()
        }
        
    }

    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        print("Back Button at Lights VC")
        let vc: ViewController? = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        self.present(vc!, animated: true, completion: nil)
        
        
    }
    @IBAction func shareButtonAction(_ sender: UIButton) {
        
        print("Sahre Button at Lights VC")
        
        
        let vc: ShareVC? = self.storyboard?.instantiateViewController(withIdentifier: "ShareVC") as? ShareVC
        
        vc?.image = frontImageView.image
        self.present(vc!, animated: true, completion: nil)
        //  UIImageWriteToSavedPhotosAlbum(frontImageView.image!, self, nil, nil)
       // sharePhoto()
    }
    
    var activityPopoverController: UIPopoverController?
    func sharePhoto() {
        if frontImageView?.image == nil {
            return
        }
        let activityController = UIActivityViewController(activityItems: [frontImageView?.image! as Any], applicationActivities: nil)
        if UI_USER_INTERFACE_IDIOM() == .phone {
            present(activityController, animated: true, completion: { _ in })
        }
        else {
            //clang diagnostic push
            //clang diagnostic ignored "-Wdeprecated-declarations"
            activityPopoverController?.dismiss(animated: false)
            activityPopoverController = UIPopoverController(contentViewController: activityController)
            activityPopoverController?.present(from: navigationItem.rightBarButtonItem!, permittedArrowDirections: .any, animated: true)
            //clang diagnostic pop
        }
    }
    
    
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        
         self.imageFromStickerVC = self.returnFinalImage()
        self.sliderOutlet.isHidden = true
        print("Done Button at Stickers VC")
        if stickerDelegate != nil {
            
            stickerDelegate?.stickerDidFinish(self)
        }
        self.dismiss(animated: false, completion: nil)
        
    }

    
    
    @IBAction func crossButtonAction(_ sender: UIButton) {
        
        print("Cross Button at Stickers VC")
        
        self.dismiss(animated: false, completion: nil)
        
    }
    

    
    var deleteImageView : UIImageView!
    var tagValue : Int?
    func tapGesture(sender:UITapGestureRecognizer) {
        let tag:Int = (sender.view?.tag)!
        tagValue = tag
        
        deleteImageView = view.viewWithTag(tag) as! UIImageView
        let alert = UIAlertController(title: "Alert", message: "You want to delete it ", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
            
            self.deleteImageView.removeFromSuperview()
            
        }))
        
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    func pinchGesture(sender:UIPinchGestureRecognizer) {
        
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        }
        
    }
    
    func panGesture(sender:UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x,y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    func rotateGesture(sender:UIRotationGestureRecognizer) {
        
        if let view = sender.view {
            view.transform = view.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        }
    }
    
    @objc func gestureRecognizer(_: UIGestureRecognizer,
                                 shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
    func returnFinalImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(frontImageView.frame.size, frontImageView.isOpaque, 0.0)
        contentView.drawHierarchy(in: CGRect(x: CGFloat(frontImageView.frame.origin.x), y: CGFloat(0), width: CGFloat(frontImageView.frame.size.width), height: CGFloat(frontImageView.frame.size.height)), afterScreenUpdates: true)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}

