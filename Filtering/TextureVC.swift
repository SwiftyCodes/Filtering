//
//  TextureVC.swift
//  Filtering
//
//  Created by Polak on 5/30/17.
//  Copyright © 2017 Polak. All rights reserved.
//

import UIKit
import AVFoundation

protocol TextureDelegate:class {
    func textureDidFinish(_ textureVC:TextureVC)
}

class TextureVC: UIViewController,UIScrollViewDelegate {
    
    var image:UIImage?
    
    var textureDelegate:TextureDelegate?
    var imageFromtTextureVC : UIImage?
    
    
    @IBOutlet weak var centerScrollView: UIScrollView!
    
    @IBOutlet weak var contentView : UIView!
    
    @IBOutlet weak var backImageView : UIImageView!
    
    @IBOutlet weak var frontImageView : UIImageView!
    
    @IBOutlet weak var toolsScrollView: UIScrollView!
    @IBOutlet weak var subToolsScrollView: UIScrollView!
    
    @IBOutlet weak var subToolsView: UIView!
    @IBOutlet weak var subToolsLabel: UILabel!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    
    
    var textureImageArray = ["tt1","tt2","tt3","tt4","tt5","tt6","tt7","tt8","tt9","tt10","tt11","tt12","tt13","tt14","tt15","tt16","tt17","tt18","tt19","tt20","tt21","tt23","tt24","tt25"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontImageView.alpha = 0.5
        
        self.subToolsLabel.text = "Textures"
        // Do any additional setup after loading the view.
        
        backImageView.frame = AVMakeRect(aspectRatio: (image?.size)!, insideRect: backImageView.bounds)
        backImageView.image = image
        
        frontImageView.frame = AVMakeRect(aspectRatio: (image?.size)!, insideRect: frontImageView.bounds)
        frontImageView.image = image
        
        
        
        textureScrollerCreation()
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
    func textureScrollerCreation() {
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 50.0
        let buttonHeight: CGFloat = 50.0
        let gapBetweenButtons: CGFloat = 5
        
        
        for i in 0..<textureImageArray.count{
            itemCount = i
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = itemCount
            filterButton.showsTouchWhenHighlighted = true
            filterButton.contentMode = .scaleAspectFill
            
            let myimage = UIImage(named: textureImageArray[itemCount])
            filterButton.setImage(myimage, for: .normal)
            
            filterButton.addTarget(self, action:#selector(textureButtonTapped), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            xCoord +=  buttonWidth + gapBetweenButtons
            subToolsScrollView.addSubview(filterButton)
        }
        
        subToolsScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+3), height: yCoord)
        
        
    }
    
    
    var filterItem : Int?
    
    func textureButtonTapped(sender: UIButton) {
        let button = sender as UIButton
        filterItem = button.tag
        
        UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
            self.frontImageView.image = UIImage(named: self.textureImageArray[button.tag])
        }, completion: { _ in })
        
   
        UIView.transition(with: sliderOutlet, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
            self.sliderOutlet.isHidden = false
        }, completion: { _ in })
        
        imageFromtTextureVC = returnFinalImage()
        
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        
        DispatchQueue.main.async
            {
        self.frontImageView.alpha = CGFloat(sender.value)
        self.imageFromtTextureVC = self.returnFinalImage()
        }
        
    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        print("Back Button at Texture VC")
        let vc: ViewController? = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController

        self.present(vc!, animated: true, completion: nil)
        
        
    }
    @IBAction func shareButtonAction(_ sender: UIButton) {
        
        print("Sahre Button at Texture VC")
        
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

    
    
    @IBAction func crossButtonAction(_ sender: UIButton) {
    
         print("Cross Button at Texture VC")
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        
        self.sliderOutlet.isHidden = true
        print("Done Button at Texture VC")
        if textureDelegate != nil {
            
            textureDelegate?.textureDidFinish(self)
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
