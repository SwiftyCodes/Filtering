//
//  LightsVC.swift
//  Filtering
//
//  Created by Polak on 5/30/17.
//  Copyright © 2017 Polak. All rights reserved.
//

import UIKit
import AVFoundation

protocol LightsDelegate:class {
    func lightsDidFinish(_ lightsVC:LightsVC)
}


class LightsVC: UIViewController,UIScrollViewDelegate{
    
    var image:UIImage?
    
    var lightsDelegate:LightsDelegate?
    var imageFromtLightsVC : UIImage?
    
    @IBOutlet weak var centerScrollView: UIScrollView!
    
    @IBOutlet weak var contentView : UIView!
    
    @IBOutlet weak var backImageView : UIImageView!
    
    @IBOutlet weak var frontImageView : UIImageView!
    
    @IBOutlet weak var toolsScrollView: UIScrollView!
    @IBOutlet weak var subToolsScrollView: UIScrollView!
    
    @IBOutlet weak var subToolsView: UIView!
    @IBOutlet weak var subToolsLabel: UILabel!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    
    
    var lightsImageArray = ["lt1","lt2","lt3","lt4","lt5","lt6","lt7","lt8","lt9","lt10","lt11","lt12","lt13","lt14","lt15","lt16","lt17","lt18","lt19","lt20","lt21","lt22","lt23","lt24","lt25"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontImageView.alpha = 0.5

        self.subToolsLabel.text = "Lights"
        // Do any additional setup after loading the view.
        
        backImageView.frame = AVMakeRect(aspectRatio: (image?.size)!, insideRect: backImageView.bounds)
        backImageView.image = image
        
        frontImageView.frame = AVMakeRect(aspectRatio: (image?.size)!, insideRect: frontImageView.bounds)
        frontImageView.image = image
        
        
        lightsScrollerCreation()
        self.sliderOutlet.isHidden = true
        
        self.centerScrollView.minimumZoomScale = 1.0
        self.centerScrollView.maximumZoomScale = 2.5
    }

    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
    

    
    var itemCount = 0
    func lightsScrollerCreation() {
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 50.0
        let buttonHeight: CGFloat = 50.0
        let gapBetweenButtons: CGFloat = 5
        
        
        for i in 0..<lightsImageArray.count{
            itemCount = i
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = itemCount
            filterButton.showsTouchWhenHighlighted = true
            filterButton.contentMode = .scaleAspectFill
            
            let myimage = UIImage(named: lightsImageArray[itemCount])
            filterButton.setImage(myimage, for: .normal)
            
            filterButton.addTarget(self, action:#selector(lightsButtonTapped), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            xCoord +=  buttonWidth + gapBetweenButtons
            subToolsScrollView.addSubview(filterButton)
        }
        
        subToolsScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+3), height: yCoord)
        
        
    }
    
    var filterItem : Int?
    
    func lightsButtonTapped(sender: UIButton) {
        let button = sender as UIButton
        filterItem = button.tag
        
        UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
           self.frontImageView.image = UIImage(named: self.lightsImageArray[button.tag])
        }, completion: { _ in })
        
        
        
        
        
        UIView.transition(with: sliderOutlet, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
            self.sliderOutlet.isHidden = false
        }, completion: { _ in })
        
        imageFromtLightsVC = returnFinalImage()
        
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        
        DispatchQueue.main.async
            {
                self.frontImageView.alpha = CGFloat(sender.value)
                self.imageFromtLightsVC = self.returnFinalImage()
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
    //    sharePhoto()
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
    
    
    
    @IBAction func crossButtonAction(_ sender: UIButton) {
        
        print("Cross Button at Lights VC")
        
        self.dismiss(animated: false, completion: nil)
        
    }

    @IBAction func doneButtonAction(_ sender: UIButton) {
        
        self.sliderOutlet.isHidden = true
        print("Done Button at Texture VC")
        if lightsDelegate != nil {
            
            lightsDelegate?.lightsDidFinish(self)
        }
        self.dismiss(animated: false, completion: nil)
        
    }
    
    func returnFinalImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(frontImageView.frame.size, frontImageView.isOpaque, 0.0)
        contentView.drawHierarchy(in: CGRect(x: CGFloat(frontImageView.frame.origin.x), y: CGFloat(0), width: CGFloat(frontImageView.frame.size.width), height: CGFloat(frontImageView.frame.size.height)), afterScreenUpdates: true)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }


}
