//
//  BeautyVC.swift
//  Filtering
//
//  Created by Polak on 5/31/17.
//  Copyright © 2017 Polak. All rights reserved.
//

import UIKit
import AVFoundation
import GPUImage

protocol BeautyDelegate:class {
    func beautyDidFinish(_ beautyVC:BeautyVC)
}

class BeautyVC: UIViewController,UIScrollViewDelegate{

    
    var image:UIImage?
    
    var beautyDelegate:BeautyDelegate?
    var imageFromtBeautyVC : UIImage?
    var multiplefilterarray = [UIImage]()
    
    var appDelegate : AppDelegate!
    
    
    @IBOutlet weak var centerScrollView: UIScrollView!
    
    @IBOutlet weak var contentView : UIView!
    
    @IBOutlet weak var backImageView : UIImageView!
    
    @IBOutlet weak var frontImageView : UIImageView!
    
    @IBOutlet weak var toolsScrollView: UIScrollView!
    @IBOutlet weak var subToolsScrollView: UIScrollView!
    
    @IBOutlet weak var subToolsView: UIView!
    @IBOutlet weak var subToolsLabel: UILabel!
    
    @IBOutlet weak var sliderOutlet: UISlider!

    var FilterArrayImages = ["echo","cruz1","flume","coast","tiki","athens","oak1","waves","tokyo","kayak","lincolun1","rio","newport","nova","market1","sketch1","radio","marid1","flux","petra","organic","nomad1","golden","fairy1","alya","moissa","luma","electra","cora","iris1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.subToolsLabel.text = "Beauty"
        
        backImageView.frame = AVMakeRect(aspectRatio: (image?.size)!, insideRect: backImageView.bounds)
        backImageView.image = image
        
        frontImageView.frame = AVMakeRect(aspectRatio: (image?.size)!, insideRect: frontImageView.bounds)
        frontImageView.image = image
        
        creation()
        self.sliderOutlet.isHidden = true
        
        self.centerScrollView.minimumZoomScale = 1.0
        self.centerScrollView.maximumZoomScale = 2.5
        
    
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        multiplefilterarray = [AnyObject]() as! [UIImage]
//        multiplefilterarray.append(UIImage(named: "1.JPG")!)
//        for i in 1..<StylishImage.count {
//            
//            let AmatorkaFilter = GPUImageAmatorkaFilter()
//            AmatorkaFilter = nil
//            appDelegate.imageNamed1 = filterArr[i]
//            AmatorkaFilter = GPUImageAmatorkaFilter()
//            multiplefilterarray.append(AmatorkaFilter.imageByFilteringImage(self.editarray[0]))
//        }
//
    
        
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
    

    var itemCount : Int?
    func creation() {
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 50.0
        let buttonHeight: CGFloat = 50.0
        let gapBetweenButtons: CGFloat = 5
        var itemCount = 0
        
        //        let subViews = self.filterScrollView.subviews
        //        for subview in subViews{
        //            subview.removeFromSuperview()
        //        }
        
        subToolsScrollView.translatesAutoresizingMaskIntoConstraints = false
        for i in 0..<FilterArrayImages.count {
            itemCount = i
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = itemCount
            let myimage = UIImage(named: FilterArrayImages[itemCount])
            filterButton.setImage(myimage, for: .normal)
            filterButton.addTarget(self, action:#selector(FilterTapped), for: .touchUpInside)
            filterButton.layer.cornerRadius = 5
            filterButton.clipsToBounds = true
            
            xCoord +=  buttonWidth + gapBetweenButtons
            subToolsScrollView.addSubview(filterButton)
            
        }
        subToolsScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+4), height: yCoord)
    }
    
 
    
    var filterItem : Int?
    func FilterTapped(sender: UIButton) {
        let button = sender as UIButton
        filterItem = button.tag
        switch button.tag {
            
        case 0:
            
            print("Amatorka Filter Applied")
            
            let AmatorkaFilter = GPUImageAmatorkaFilter()

            let quickFilteredImage: UIImage? = AmatorkaFilter.image(byFilteringImage: image)
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })
 
            
        case 1:
            
            print("Ekitikate Filter Applied")
            
            let EktikateFilter = GPUImageMissEtikateFilter()
            
            let quickFilteredImage: UIImage? = EktikateFilter.image(byFilteringImage: image)
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })
            
            
        case 2:
            
            print("Sepia  Filter Applied")
  
            
            let SepiaFilter = GPUImageSepiaFilter()
            
            let quickFilteredImage: UIImage? = SepiaFilter.image(byFilteringImage: image)
            
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })

            
        case 3:
            
            print("Saturation  Filter Applied")
            
            
            let SaturationFilter = GPUImageSaturationFilter()
            SaturationFilter.saturation = 2.0
            
            let quickFilteredImage: UIImage? = SaturationFilter.image(byFilteringImage: image)
            
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })

      
            
        case 4:
            
            print("Brightness/Dark  Filter Applied")
            
            
            let BrightnessFilter = GPUImageBrightnessFilter()
            BrightnessFilter.brightness = -0.2
            
            let quickFilteredImage: UIImage? = BrightnessFilter.image(byFilteringImage: image)
            
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })
 
            
        case 5:
            
            print("Brightness/Light  Filter Applied")
            
            
            let BrightnessFilter = GPUImageBrightnessFilter()
            BrightnessFilter.brightness = 0.3
            
            let quickFilteredImage: UIImage? = BrightnessFilter.image(byFilteringImage: image)
            
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })

            
            
        case 6:
   
            
            print("Toon  Filter Applied")
            
            let ToonFilter = GPUImageToonFilter()
            ToonFilter.threshold = 0.5
            
            
            let quickFilteredImage: UIImage? = ToonFilter.image(byFilteringImage: image)
            
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })
            
            
        case 7:
            
            
            print("GrayScale  Filter Applied")
            
            let GrayScaleFilter = GPUImageGrayscaleFilter()
            
            
            let quickFilteredImage: UIImage? = GrayScaleFilter.image(byFilteringImage: image)
            
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })

            
        case 8:
            
            print("Hue Filter Applied")
            
            
            let HueFilter = GPUImageHueFilter()
            
            
            let quickFilteredImage: UIImage? = HueFilter.image(byFilteringImage: image)
            
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })

            
        case 9:
            
            print("Solarize Filter Applied")
            let SolarizeFilter = GPUImageSolarizeFilter()
            
            
            let quickFilteredImage: UIImage? = SolarizeFilter.image(byFilteringImage: image)
            
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })

            
        case 10:
            
            print("Hue TOON Filter Applied")
           
            let toonFilter  = GPUImageToonFilter()
            toonFilter.threshold = 0.5
            let quickFilteredImage: UIImage? = toonFilter.image(byFilteringImage: image)
            let  HueGpuFilter = GPUImageHueFilter()
            let hueFilteredImage: UIImage? = HueGpuFilter.image(byFilteringImage: quickFilteredImage)
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })
           

            
            
        case 11:
            
            print("Saturation Amatorka Filter Applied")
            
            let SaturationFilter = GPUImageSaturationFilter()
            SaturationFilter.saturation = 2.0
            let quickFilteredImage: UIImage? = SaturationFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageAmatorkaFilter()
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })
            

            
        case 12:
            
            
            print("Brightness Amatorka Filter Applied")
            
            let BrightnessFilter = GPUImageBrightnessFilter()
            BrightnessFilter.brightness = 0.3
            let quickFilteredImage: UIImage? = BrightnessFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageAmatorkaFilter()
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })

            
        case 13:
            
            print("Hue Amatorka Filter Applied")
            
            let HueFilter = GPUImageHueFilter()
            HueFilter.hue = 45.0
            let quickFilteredImage: UIImage? = HueFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageAmatorkaFilter()
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })

            
        case 14:

          
           print("Sepia Amotorka Filter Applied")
            
            let SepiaFilter = GPUImageSepiaFilter()
            let quickFilteredImage: UIImage? = SepiaFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageAmatorkaFilter()
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
           UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
            self.frontImageView.image = hueFilteredImage
           }, completion: { _ in })
            
            
        case 15:
            
            print("Sketch Filter Applied")
            let SketchFilter = GPUImageSketchFilter()
            SketchFilter.edgeStrength = 0.5
            let quickFilteredImage: UIImage? = SketchFilter.image(byFilteringImage: image)
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })
            
        case 16:
            
            print("Biletral Filter Applied")
            let BiletralFilter = GPUImageBilateralFilter()
            BiletralFilter.texelSpacingMultiplier = 10.0
            BiletralFilter.distanceNormalizationFactor = 4.0
            let quickFilteredImage: UIImage? = BiletralFilter.image(byFilteringImage: image)
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })

            
        case 17:
            
            print("Amatorka TOON Filter Applied")
            let ToonFilter = GPUImageToonFilter()
            ToonFilter.threshold = 0.5
            let quickFilteredImage: UIImage? = ToonFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageAmatorkaFilter()
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })
            
        case 18:
            
            print("Pixellate Toon Filter Applied")
            let PixalleteFilter = GPUImagePixellateFilter()
            PixalleteFilter.fractionalWidthOfAPixel = 0.009
            let quickFilteredImage: UIImage? = PixalleteFilter.image(byFilteringImage: image)
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })
            
        case 19:
            
            print("Gray SCALE Amatorka Filter Applied")
            let grayFilter  = GPUImageGrayscaleFilter()
            let quickFilteredImage: UIImage? = grayFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageAmatorkaFilter()
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })
            
            
        case 20:
            
            print("Gray SCALE Etikate Filter Applied")
            let grayFilter  = GPUImageGrayscaleFilter()
            let quickFilteredImage: UIImage? = grayFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageMissEtikateFilter()
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })
            
        case 21:
            
            print("Gray SCALE Toon Filter Applied")
            let grayFilter  = GPUImageGrayscaleFilter()
            let quickFilteredImage: UIImage? = grayFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageToonFilter()
            AmatorkaGpuFilter.threshold = 0.5
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })
            
        case 22:
            
            print("Saturation Etikate Filter Applied")
            
            let SaturationFilter = GPUImageSaturationFilter()
            SaturationFilter.saturation = 1.5
            let quickFilteredImage: UIImage? = SaturationFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageMissEtikateFilter()
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })
            
        case 23:
            
            print("Brightness Etikate Filter Applied")
            
            let BrightnessFilter = GPUImageBrightnessFilter()
            BrightnessFilter.brightness = 0.1
            let quickFilteredImage: UIImage? = BrightnessFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageMissEtikateFilter()
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })
            
        case 24:
            
            print("Hue Etikate Filter Applied")
            
            let BrightnessFilter = GPUImageHueFilter()
            BrightnessFilter.hue = 180.0
            let quickFilteredImage: UIImage? = BrightnessFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageMissEtikateFilter()
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })
            
        case 25:
            
            
            print("softEleganceFilter Saturation  Filter Applied")
            let SaturationFilter = GPUImageSaturationFilter()
            SaturationFilter.saturation = 1.5

            let quickFilteredImage: UIImage? = SaturationFilter.image(byFilteringImage: image)
            
            let softEleganceFilter = GPUImageSoftEleganceFilter()
 
            let hueFilteredImage: UIImage? = softEleganceFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })
            
            
            
        case 26:
            
            
            print("softEleganceFilter  Filter Applied")
            
            let softEleganceFilter = GPUImageSoftEleganceFilter()
            
            
            let quickFilteredImage: UIImage? = softEleganceFilter.image(byFilteringImage: image)
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })
            
        case 27:
            
            print("softEleganceFilter Monochrome Filter Applied")
            
            let monoSchoreFilter = GPUImageMonochromeFilter()
            let quickFilteredImage: UIImage? = monoSchoreFilter.image(byFilteringImage: image)
            
            let softEleganceFilter = GPUImageSoftEleganceFilter()
            
            let hueFilteredImage: UIImage? = softEleganceFilter.image(byFilteringImage: quickFilteredImage)
            frontImageView.image = hueFilteredImage
            
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = quickFilteredImage
            }, completion: { _ in })
            
        case 28:
            
            print("Amatoka Sahrpness Filter Applied")
            

            let SharpnessFilter = GPUImageSharpenFilter()
            SharpnessFilter.sharpness = 3.0
            let quickFilteredImage: UIImage? = SharpnessFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageAmatorkaFilter()
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })
            
        case 29:
            
            print("Etikate Sahrpness Filter Applied")
      
            let SharpnessFilter = GPUImageSharpenFilter()
            SharpnessFilter.sharpness = 3.0
            let quickFilteredImage: UIImage? = SharpnessFilter.image(byFilteringImage: image)
            let  AmatorkaGpuFilter = GPUImageMissEtikateFilter()
            let hueFilteredImage: UIImage? = AmatorkaGpuFilter.image(byFilteringImage: quickFilteredImage)
            UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
                self.frontImageView.image = hueFilteredImage
            }, completion: { _ in })
            
        default:
            break
        }
        
        imageFromtBeautyVC = returnFinalImage()
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
        
        print("Cross Button at Beauty VC")
        
        self.dismiss(animated: false, completion: nil)
        
    }


    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        
        self.sliderOutlet.isHidden = true
        print("Done Button at Beauty VC")
        if beautyDelegate != nil {
            
            beautyDelegate?.beautyDidFinish(self)
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
