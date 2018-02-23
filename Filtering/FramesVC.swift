//
//  FramesVC.swift
//  
//
//  Created by Polak on 5/30/17.
//
//

import UIKit
import AVFoundation

protocol FramesDelegate:class {
    func framesDidFinish(_ framesVC:FramesVC)
}


class FramesVC: UIViewController,UIScrollViewDelegate {
    
    var image:UIImage?
    
    var framesDelegate:FramesDelegate?
    var imageFromtFramesVC : UIImage?
    
    @IBOutlet weak var centerScrollView: UIScrollView!
    
    @IBOutlet weak var contentView : UIView!
    
    @IBOutlet weak var backImageView : UIImageView!
    
    @IBOutlet weak var frontImageView : UIImageView!
    
    @IBOutlet weak var toolsScrollView: UIScrollView!
    @IBOutlet weak var subToolsScrollView: UIScrollView!
    
    @IBOutlet weak var subToolsView: UIView!
    @IBOutlet weak var subToolsLabel: UILabel!
    
    @IBOutlet weak var sliderOutlet: UISlider!

    var framesImageArray = ["ft1","ft2","ft3","ft4","ft5","ft6","ft7","ft8","ft9","ft10","ft11","ft12","ft13","ft14","ft15","ft16","ft17","ft18","ft19","ft20"]


    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        self.subToolsLabel.text = "Frames"
        // Do any additional setup after loading the view.
        
        backImageView.frame = AVMakeRect(aspectRatio: (image?.size)!, insideRect: backImageView.bounds)
        backImageView.image = image
        
//        frontImageView.frame = AVMakeRect(aspectRatio: (image?.size)!, insideRect: frontImageView.bounds)
//        frontImageView.image = image
        
        
        framesScrollerCreation()
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
    func framesScrollerCreation() {
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 50.0
        let buttonHeight: CGFloat = 50.0
        let gapBetweenButtons: CGFloat = 5
        
        
        for i in 0..<framesImageArray.count{
            itemCount = i
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = itemCount
            filterButton.showsTouchWhenHighlighted = true
            filterButton.contentMode = .scaleAspectFill
            
            let myimage = UIImage(named: framesImageArray[itemCount])
            filterButton.setImage(myimage, for: .normal)
            
            filterButton.addTarget(self, action:#selector(framesButtonTapped), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            xCoord +=  buttonWidth + gapBetweenButtons
            subToolsScrollView.addSubview(filterButton)
        }
        
        subToolsScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+3), height: yCoord)
        
        
    }
    
    var filterItem : Int?
    
    func framesButtonTapped(sender: UIButton) {
        let button = sender as UIButton
        filterItem = button.tag
        
        UIView.transition(with: frontImageView, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
             self.frontImageView.image = UIImage(named: self.framesImageArray[button.tag])
        }, completion: { _ in })
        
 
        UIView.transition(with: sliderOutlet, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
            self.sliderOutlet.isHidden = false
        }, completion: { _ in })
        
        imageFromtFramesVC = returnFinalImage()
        
    }
    

    
    @IBAction func sliderAction(_ sender: UISlider) {
        
        DispatchQueue.main.async
            {
                self.frontImageView.alpha = CGFloat(sender.value)
                self.imageFromtFramesVC = self.returnFinalImage()
        }
        
    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        print("Back Button at Frames VC")
        let vc: ViewController? = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        self.present(vc!, animated: true, completion: nil)
        
        
    }
    @IBAction func shareButtonAction(_ sender: UIButton) {
        
        print("Sahre Button at Frames VC")
        
        let vc: ShareVC? = self.storyboard?.instantiateViewController(withIdentifier: "ShareVC") as? ShareVC
        
        vc?.image = frontImageView.image
        self.present(vc!, animated: true, completion: nil)
        //  UIImageWriteToSavedPhotosAlbum(frontImageView.image!, self, nil, nil)
      //  sharePhoto()
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
        
        print("Cross Button at Frames VC")
        
        self.dismiss(animated: false, completion: nil)
        
    }

    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        
        self.sliderOutlet.isHidden = true
        print("Done Button at Frames VC")
        if framesDelegate != nil {
            
            framesDelegate?.framesDidFinish(self)
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
