

import UIKit
import AVFoundation
import TOCropViewController


class TuneToolsVC: UIViewController,UIScrollViewDelegate,TOCropViewControllerDelegate,TextureDelegate,LightsDelegate,FramesDelegate,StickerDelegate,BeautyDelegate{
    
    
    @IBOutlet weak var centerScrollView: UIScrollView!
    
    @IBOutlet weak var contentView : UIView!
    
    @IBOutlet weak var backImageView : UIImageView!
    
    @IBOutlet weak var frontImageView : UIImageView!

    @IBOutlet weak var toolsScrollView: UIScrollView!
    @IBOutlet weak var subToolsScrollView: UIScrollView!
    
    @IBOutlet weak var subToolsView: UIView!
    @IBOutlet weak var subToolsLabel: UILabel!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    
    var imageFromCameraVC:UIImage?

    var aCIImage = CIImage();
    
    var gaussianBlurFilter: CIFilter!;
    var sharpnessFilter: CIFilter!;
    var whitebalanceFilter: CIFilter!;
    var hrdFilter: CIFilter!;
    var vignetteFilter: CIFilter!;
    
    var context = CIContext();
    var outputImage = CIImage();
    var newUIImage = UIImage();
    var finalImage = UIImage()

    var tuneToolsImageArray = ["crop","adjust","filters-with-text","beauty","textures","lights","frames","stickers"]
    
    var subTuneAdjustToolsImageArray = ["brightness","exposure","sharpness","shadow","vignette","saturation","sepia4","hue4"]

    
    var CIFilterNames = [
        "CIColorMonochrome",
        "CIPhotoEffectNoir",
        "CIColorPosterize",
        "CIFalseColor",
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectMono",
        "CIColorInvert",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CISepiaTone"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontImageView.alpha = 1.0
        
        backImageView.frame = AVMakeRect(aspectRatio: (imageFromCameraVC?.size)!, insideRect: backImageView.bounds)
        backImageView.image = imageFromCameraVC
        
        frontImageView.frame = AVMakeRect(aspectRatio: (imageFromCameraVC?.size)!, insideRect: frontImageView.bounds)
        frontImageView.image = imageFromCameraVC
      

        self.subToolsView.isHidden = true
        self.sliderOutlet.isHidden = true
        tuneToolsScrollViewContentCreation()
        AdjustsubTuneToolsScrollViewContentCreation()
        

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

    var toolsScrollViewCount = 0
    func tuneToolsScrollViewContentCreation() {
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 55.0
        let buttonHeight: CGFloat = 55.0
        let gapBetweenButtons: CGFloat = 5
        
        for i in 0..<tuneToolsImageArray.count{
            toolsScrollViewCount = i
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = toolsScrollViewCount
            filterButton.backgroundColor = UIColor.clear
            filterButton.showsTouchWhenHighlighted = true
            let myimage = UIImage(named: tuneToolsImageArray[toolsScrollViewCount])
            filterButton.setImage(myimage, for: .normal)
            filterButton.addTarget(self, action:#selector(toolsScrollViewItemTapped), for: .touchUpInside)
            filterButton.layer.cornerRadius = 5
            filterButton.clipsToBounds = true
            
            xCoord +=  buttonWidth + gapBetweenButtons
            toolsScrollView.addSubview(filterButton)
            
        }
        toolsScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(toolsScrollViewCount+2), height: yCoord)
        
    }
    

    var texturePressed = false
    func toolsScrollViewItemTapped(sender:UIButton) {
        
        switch sender.tag {
            
        case 0:
            
            print("Crop Tapped")
            
//            self.subToolsLabel.text = "Crop"
//            self.subToolsView.isHidden = false
//            self.sliderOutlet.isContinuous = true
//            
//            let subViews = self.subToolsScrollView.subviews
//            for subview in subViews{
//                subview.removeFromSuperview()
//            }
            
            presentViewController()
            
            
        case 1:
            
            print("Adjust Tapped")
            self.subToolsLabel.text = "Adjustment"
            self.subToolsView.isHidden = false
            
            texturePressed = false
            let subViews = self.subToolsScrollView.subviews
            for subview in subViews{
                subview.removeFromSuperview()
            }
            AdjustsubTuneToolsScrollViewContentCreation()
            
        case 2:
            
            print("Filters Tapped")
            print("CIFilters")
            texturePressed = false
            self.subToolsLabel.text = "Filters"
            self.subToolsView.isHidden = false
     
            
            let subViews = self.subToolsScrollView.subviews
            for subview in subViews{
                subview.removeFromSuperview()
            }
            
            filterScrollCreation()
      
        case 3:
            
            print("Beauty Tapped")
            texturePressed = false
//            self.subToolsLabel.text = "Beauty"
//            self.subToolsView.isHidden = false
//            
//            let subViews = self.subToolsScrollView.subviews
//            for subview in subViews{
//                subview.removeFromSuperview()
//            }
            
            let vc: BeautyVC? = self.storyboard?.instantiateViewController(withIdentifier: "BeautyVC") as? BeautyVC
            
            vc?.beautyDelegate = self
            vc?.image = frontImageView.image
            self.present(vc!, animated: false, completion: nil)
            
        case 4:
            
            print("Textures Tapped")
            texturePressed = true
          //  self.subToolsLabel.text = "Textures"
//            self.subToolsView.isHidden = false
//          
//            
//            let subViews = self.subToolsScrollView.subviews
//            for subview in subViews{
//                subview.removeFromSuperview()
//            }
            
            
            let vc: TextureVC? = self.storyboard?.instantiateViewController(withIdentifier: "TextureVC") as? TextureVC
            
            vc?.textureDelegate = self
            vc?.image = frontImageView.image
            self.present(vc!, animated: false, completion: nil)
           
            
        case 5:
            
            print("Light Tapped")
            texturePressed = false
//            self.subToolsLabel.text = "Light"
//            self.subToolsView.isHidden = false
//           
//            
//            let subViews = self.subToolsScrollView.subviews
//            for subview in subViews{
//                subview.removeFromSuperview()
//                
//            
//            }
            
            let vc: LightsVC? = self.storyboard?.instantiateViewController(withIdentifier: "LightsVC") as? LightsVC
            
            vc?.lightsDelegate = self
            vc?.image = frontImageView.image
            self.present(vc!, animated: false, completion: nil)
            
            
        case 6:
            
            print("Frames Tapped")
            texturePressed = false
//            self.subToolsLabel.text = "Frames"
//            self.subToolsView.isHidden = false
//          
//            
//            let subViews = self.subToolsScrollView.subviews
//            for subview in subViews{
//                subview.removeFromSuperview()
//            }
            
            let vc: FramesVC? = self.storyboard?.instantiateViewController(withIdentifier: "FramesVC") as? FramesVC
            
            vc?.framesDelegate = self
            vc?.image = frontImageView.image
            self.present(vc!, animated: false, completion: nil)
//
            
        case 7:
            
            print("Stickers Tapped")
            texturePressed = false
//            self.subToolsLabel.text = "Stickers"
//            self.subToolsView.isHidden = false
//            
//            
//            let subViews = self.subToolsScrollView.subviews
//            for subview in subViews{
//                subview.removeFromSuperview()
            
            let vc: StickersVC? = self.storyboard?.instantiateViewController(withIdentifier: "StickersVC") as? StickersVC
            
            vc?.stickerDelegate = self
            vc?.image = frontImageView.image
            self.present(vc!, animated: false, completion: nil)
      
            
            
        default:
            break
        }
        
    }
    
    //MARK: Cropper Tool
    func presentViewController() {
        // let image: UIImage?
        let imageView = UIImageView(image: frontImageView.image)
        _ = self.view.convert(imageView.frame, to: self.view)
        let cropViewController = TOCropViewController(image: frontImageView.image!)
        cropViewController.delegate = self
        self.present(cropViewController, animated: true, completion: { _ in })
    }
    
    
    @objc(cropViewController:didCropToImage:withRect:angle:) func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        
      //  frontImageView.frame = AVMakeRect(aspectRatio: (image.size), insideRect: frontImageView.bounds)
        frontImageView.image = image
        frontImageView.contentMode = .scaleAspectFit
        
       // backImageView.frame = AVMakeRect(aspectRatio: (image.size), insideRect: backImageView.bounds)
        backImageView.image = image
        backImageView.contentMode = .scaleAspectFill
        
        cropViewController.dismiss(animated: true, completion: nil)
    }

    
    //ADJUST Scroll Creation
    var adjustSubToolsScrollViewCount = 0
    func AdjustsubTuneToolsScrollViewContentCreation() {
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 55.0
        let buttonHeight: CGFloat = 55.0
        let gapBetweenButtons: CGFloat = 5
        
        for i in 0..<subTuneAdjustToolsImageArray.count{
            adjustSubToolsScrollViewCount = i
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = adjustSubToolsScrollViewCount
            filterButton.backgroundColor = UIColor.clear
            filterButton.showsTouchWhenHighlighted = true
            let myimage = UIImage(named: subTuneAdjustToolsImageArray[adjustSubToolsScrollViewCount])
            filterButton.setImage(myimage, for: .normal)
            filterButton.addTarget(self, action:#selector(AdjustsubToolsScrollViewItemTapped), for: .touchUpInside)
            filterButton.layer.cornerRadius = 5
            filterButton.clipsToBounds = true
            
            xCoord +=  buttonWidth + gapBetweenButtons
            subToolsScrollView.addSubview(filterButton)
            
        }
        subToolsScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(adjustSubToolsScrollViewCount+2), height: yCoord)
        
        beforeEditingImage = frontImageView.image
        
    }

    //MARK: ADJUST Tools

    var filterSliderValue : Int!
    var beforeEditingImage : UIImage?
    
    func AdjustsubToolsScrollViewItemTapped(sender:UIButton) {
        
        
        filterSliderValue = sender.tag
        switch sender.tag {
            
        case 0:
            
            print("Brightness Tapped")
            
            frontImageView.image = returnFinalImage()
            let aUIImage = frontImageView.image;
            let aCGImage = aUIImage?.cgImage;
            aCIImage = CIImage(cgImage: aCGImage!)
            context = CIContext(options: nil);
            
            UIView.transition(with: sliderOutlet, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
                self.sliderOutlet.isHidden = false
            }, completion: { _ in })
            
            sliderOutlet.minimumValue = -0.3
            sliderOutlet.value = 0.0
            sliderOutlet.maximumValue = 0.3
            
   
        case 1:
            
            print("Exposure Tapped")
            
            frontImageView.image = returnFinalImage()
            let aUIImage = frontImageView.image;
            let aCGImage = aUIImage?.cgImage;
            aCIImage = CIImage(cgImage: aCGImage!)
            context = CIContext(options: nil);
            
            UIView.transition(with: sliderOutlet, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
                self.sliderOutlet.isHidden = false
            }, completion: { _ in })
            
            sliderOutlet.minimumValue = -1.0
            sliderOutlet.value = 0.5
            sliderOutlet.maximumValue = 3.0
  
        case 2:
            
            print("Sharpness Tapped")
            
            frontImageView.image = returnFinalImage()
            let aUIImage = frontImageView.image;
            let aCGImage = aUIImage?.cgImage;
            aCIImage = CIImage(cgImage: aCGImage!)
            context = CIContext(options: nil);
            
            UIView.transition(with: sliderOutlet, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
                self.sliderOutlet.isHidden = false
            }, completion: { _ in })
            
            sliderOutlet.minimumValue = 0.0
            sliderOutlet.value = 4.0
            sliderOutlet.maximumValue = 20.0
     
        case 3:
            
            print("HighlightShadow Tapped")
            
            frontImageView.image = returnFinalImage()
            let aUIImage = frontImageView.image;
            let aCGImage = aUIImage?.cgImage;
            aCIImage = CIImage(cgImage: aCGImage!)
            context = CIContext(options: nil);
            
            UIView.transition(with: sliderOutlet, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
                self.sliderOutlet.isHidden = false
            }, completion: { _ in })
            
            
            sliderOutlet.minimumValue = -3.0
            sliderOutlet.value = 1.0
            sliderOutlet.maximumValue = 3.0

        case 4:
            
            print("CIVignette Tapped")
            
            frontImageView.image = returnFinalImage()
            let aUIImage = frontImageView.image;
            let aCGImage = aUIImage?.cgImage;
            aCIImage = CIImage(cgImage: aCGImage!)
            context = CIContext(options: nil);
            
            UIView.transition(with: sliderOutlet, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
                self.sliderOutlet.isHidden = false
            }, completion: { _ in })
            
            sliderOutlet.minimumValue = 1.0
            sliderOutlet.value = 2.0
            sliderOutlet.maximumValue = 5.0
    
            
        case 5:
     
            print("Saturation Tapped")
            
            frontImageView.image = returnFinalImage()
            let aUIImage = frontImageView.image;
            let aCGImage = aUIImage?.cgImage;
            aCIImage = CIImage(cgImage: aCGImage!)
            context = CIContext(options: nil);
            
            UIView.transition(with: sliderOutlet, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
                self.sliderOutlet.isHidden = false
            }, completion: { _ in })
            
            sliderOutlet.minimumValue = 0.0
            sliderOutlet.value = 1.0
            sliderOutlet.maximumValue = 3.0
 
        case 6:
            
            print("Sepia Tapped")
            
            frontImageView.image = returnFinalImage()
            let aUIImage = frontImageView.image;
            let aCGImage = aUIImage?.cgImage;
            aCIImage = CIImage(cgImage: aCGImage!)
            context = CIContext(options: nil);
            UIView.transition(with: sliderOutlet, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
                self.sliderOutlet.isHidden = false
            }, completion: { _ in })
            
            sliderOutlet.minimumValue = 0.0
            sliderOutlet.value = 1.0
            sliderOutlet.maximumValue = 3.0

            
            
        case 7:
            
           print("Hue Tapped")
            
           frontImageView.image = returnFinalImage()
           let aUIImage = frontImageView.image;
           let aCGImage = aUIImage?.cgImage;
           aCIImage = CIImage(cgImage: aCGImage!)
           context = CIContext(options: nil);
           
           UIView.transition(with: sliderOutlet, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
            self.sliderOutlet.isHidden = false
           }, completion: { _ in })
           
           sliderOutlet.minimumValue = -1.0
           sliderOutlet.value = 0.0
           sliderOutlet.maximumValue = 1.0
        
            
        default:
            break
        }
        
    }
    
    //MARK: ADJUST Filter Action
    
    @IBAction func filterSliderAction(_ sender: UISlider) {
        
        switch filterSliderValue {
            
        case 0:
            
            DispatchQueue.main.async
                {
            self.gaussianBlurFilter = CIFilter(name: "CIColorControls");
            self.gaussianBlurFilter.setValue(self.aCIImage, forKey: "inputImage")
            
            self.gaussianBlurFilter.setValue(NSNumber(value: sender.value), forKey: "inputBrightness");
            self.outputImage = self.gaussianBlurFilter.outputImage!;
            
            let imageRef = self.context.createCGImage(self.outputImage, from: self.outputImage.extent)
            
            self.newUIImage = UIImage(cgImage: imageRef!)
            self.frontImageView.image = self.newUIImage;
            }
            
            
        case 1:
            
            DispatchQueue.main.async
                {
            self.gaussianBlurFilter = CIFilter(name: "CIExposureAdjust");
            self.gaussianBlurFilter.setValue(self.aCIImage, forKey: "inputImage")
            
            self.gaussianBlurFilter.setValue(NSNumber(value: sender.value), forKey: "inputEV");
            
            self.outputImage = self.gaussianBlurFilter.outputImage!;
            
            let imageRef = self.context.createCGImage(self.outputImage, from: self.outputImage.extent)
            
            self.newUIImage = UIImage(cgImage: imageRef!)
            self.frontImageView.image = self.newUIImage;
            }
            //
            
            
        case 2:
            
            DispatchQueue.main.async
                {
            self.gaussianBlurFilter = CIFilter(name: "CISharpenLuminance");
            self.gaussianBlurFilter.setValue(self.aCIImage, forKey: "inputImage")
            
            self.gaussianBlurFilter.setValue(NSNumber(value: sender.value), forKey: "inputSharpness");
            
            self.outputImage = self.gaussianBlurFilter.outputImage!;
            
            let imageRef = self.context.createCGImage(self.outputImage, from: self.outputImage.extent)
            
            self.newUIImage = UIImage(cgImage: imageRef!)
            self.frontImageView.image = self.newUIImage;
            }
            
            
        case 3:
           
            DispatchQueue.main.async
                {
            self.gaussianBlurFilter = CIFilter(name: "CIHighlightShadowAdjust");
            self.gaussianBlurFilter.setValue(self.aCIImage, forKey: "inputImage")
            
            self.gaussianBlurFilter.setValue(NSNumber(value: sender.value), forKey: "inputHighlightAmount");
            
            self.outputImage = self.gaussianBlurFilter.outputImage!;
            
            let imageRef = self.context.createCGImage(self.outputImage, from: self.outputImage.extent)
            
            self.newUIImage = UIImage(cgImage: imageRef!)
            self.frontImageView.image = self.newUIImage;
            }
            
        case 4:
            
            DispatchQueue.main.async
                {
            self.gaussianBlurFilter = CIFilter(name: "CIVignette");
            self.gaussianBlurFilter.setValue(self.aCIImage, forKey: "inputImage")
            
            self.gaussianBlurFilter.setValue(NSNumber(value: sender.value), forKey: "inputRadius");
            
            self.gaussianBlurFilter.setValue(NSNumber(value: 2.0), forKey: "inputIntensity");
            
            self.outputImage = self.gaussianBlurFilter.outputImage!;
            
            let imageRef = self.context.createCGImage(self.outputImage, from: self.outputImage.extent)
            
            self.newUIImage = UIImage(cgImage: imageRef!)
         self.frontImageView.image = self.newUIImage;
                    
            }
            
        case 5:
            
            DispatchQueue.main.async
                {
                    self.gaussianBlurFilter = CIFilter(name: "CIColorControls");
                    self.gaussianBlurFilter.setValue(self.aCIImage, forKey: "inputImage")
                    
                    self.gaussianBlurFilter.setValue(NSNumber(value: sender.value), forKey: "inputSaturation");
                    
                    self.outputImage = self.gaussianBlurFilter.outputImage!;
                    
                    let imageRef = self.context.createCGImage(self.outputImage, from: self.outputImage.extent)
                    
                    self.newUIImage = UIImage(cgImage: imageRef!)
                    self.frontImageView.image = self.newUIImage;
            }
            
        case 6:
            
        DispatchQueue.main.async
                {
                    
                    self.gaussianBlurFilter = CIFilter(name: "CISepiaTone");
                    self.gaussianBlurFilter.setValue(self.aCIImage, forKey: "inputImage")
                    
                    self.gaussianBlurFilter.setValue(NSNumber(value: sender.value), forKey: "inputIntensity");
                    
                    self.outputImage = self.gaussianBlurFilter.outputImage!;
                    
                    let imageRef = self.context.createCGImage(self.outputImage, from: self.outputImage.extent)
                    
                    self.newUIImage = UIImage(cgImage: imageRef!)
                    self.frontImageView.image = self.newUIImage;
                    
            }
            
        case 7:
            
            DispatchQueue.main.async
                {
                    self.gaussianBlurFilter = CIFilter(name: "CIHueAdjust");
                    self.gaussianBlurFilter.setValue(self.aCIImage, forKey: "inputImage")
                    
                    self.gaussianBlurFilter.setValue(NSNumber(value: sender.value), forKey: "inputAngle");
                    
                    
                    self.outputImage = self.gaussianBlurFilter.outputImage!;
                    
                    let imageRef = self.context.createCGImage(self.outputImage, from: self.outputImage.extent)
                    
                    self.newUIImage = UIImage(cgImage: imageRef!)
                    self.frontImageView.image = self.newUIImage;
            }
            
            
        default:
            
            self.frontImageView.image = self.newUIImage;
            break
        }
        
    }
    
    // FILTERS Scroll Creation
    var itemCount = 0
    func filterScrollCreation() {
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 55.0
        let buttonHeight: CGFloat = 55.0
        let gapBetweenButtons: CGFloat = 5
        
        
        for i in 0..<CIFilterNames.count{
            itemCount = i
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = itemCount
            filterButton.showsTouchWhenHighlighted = true
            filterButton.contentMode = .scaleAspectFill
            filterButton.addTarget(self, action: #selector(TuneToolsVC.filterButtonTapped(_:)), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            
            
            // Create filters for each button
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: frontImageView.image!)
            let filter = CIFilter(name: "\(CIFilterNames[i])" )
            
            filter!.setDefaults()
            
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
            let imageForButton = UIImage(cgImage: filteredImageRef!);
            // Assign filtered image to the button
            
            filterButton.setBackgroundImage(imageForButton, for: UIControlState())
       
            // Add Buttons in the Scroll View
            xCoord +=  buttonWidth + gapBetweenButtons
            subToolsScrollView.addSubview(filterButton)
        }
        subToolsScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+3), height: yCoord)
        
        beforeEditingImage = frontImageView.image
    }
    
    //MARK: Filter BUtton Tapped
    func filterButtonTapped(_ sender: UIButton) {
        let button = sender as UIButton
        
        UIView.transition(with: frontImageView, duration: 0.6, options: .transitionCrossDissolve, animations: {() -> Void in
            self.frontImageView!.image = button.backgroundImage(for: UIControlState())
           
        }, completion: { _ in })
        
        
        backImageView!.image = button.backgroundImage(for: UIControlState())
      
       
        
            
    }


    @IBAction func backButtonAction(_ sender: UIButton) {
        
        print("Back Button")
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func shareButtonAction(_ sender: UIButton) {
        
        print("Share Button")
        
     //  UIImageWriteToSavedPhotosAlbum(frontImageView.image!, self, nil, nil)
        let vc: ShareVC? = self.storyboard?.instantiateViewController(withIdentifier: "ShareVC") as? ShareVC
        
        vc?.image = frontImageView.image
        self.present(vc!, animated: true, completion: nil)
        
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
        
        print("cross Button")
   
        toHidesubToolsView()
        self.sliderOutlet.isHidden = true
        frontImageView.image = beforeEditingImage
     
        
    }

    @IBAction func doneButtonAction(_ sender: UIButton) {
        
        
        print("Done Button")
        toHidesubToolsView()
        self.sliderOutlet.isHidden = true
        frontImageView.image = returnFinalImage()
        
    }
 
    func returnFinalImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(frontImageView.frame.size, frontImageView.isOpaque, 0.0)
        frontImageView.drawHierarchy(in: CGRect(x: CGFloat(frontImageView.frame.origin.x), y: CGFloat(0), width: CGFloat(frontImageView.frame.size.width), height: CGFloat(frontImageView.frame.size.height)), afterScreenUpdates: true)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    func toHidesubToolsView() {
        UIView.transition(with: subToolsView, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
            self.subToolsView.isHidden = true
        }, completion: { _ in })
        
    }
    
    
    //MARK: Texture Delegate
    var imageFromTextureVC:UIImage?
    
    func textureDidFinish(_ textureVC: TextureVC) {
        
        if textureVC.image != nil {
            imageFromTextureVC = textureVC.imageFromtTextureVC
            frontImageView.image = imageFromTextureVC
            backImageView.image = imageFromTextureVC
        }else {
            
            frontImageView.image = textureVC.backImageView.image
        }
    }
    
    
    //MARK: Lights Delegate
    var imageFromLightsVC:UIImage?
    
    func lightsDidFinish(_ lightsVC: LightsVC) {
        
        if lightsVC.image != nil {
            imageFromLightsVC = lightsVC.imageFromtLightsVC
            frontImageView.image = imageFromLightsVC
            backImageView.image = imageFromLightsVC
        }else {
            
            frontImageView.image = lightsVC.backImageView.image
        }
    }
    
    
    //MARK: Frames Delegate
    var imageFromtFramesVC:UIImage?
    
    func framesDidFinish(_ framesVC: FramesVC) {
        
        if framesVC.image != nil {
            imageFromtFramesVC = framesVC.imageFromtFramesVC
            frontImageView.image = imageFromtFramesVC
            backImageView.image = imageFromtFramesVC
        }else {
            
            frontImageView.image = framesVC.backImageView.image
        }
    }
    
    
    //MARK: Sticker Delegate Call
    var imageFromStickerVC:UIImage?
    
    func stickerDidFinish(_ stickerVC: StickersVC) {
        
        if stickerVC.image != nil {
            imageFromStickerVC = stickerVC.imageFromStickerVC
            frontImageView.image = imageFromStickerVC
            backImageView.image = imageFromStickerVC
        }else {
            
            frontImageView.image = stickerVC.frontImageView.image
        }
    }
    
    //MARK: Beauty Delegate Call
    var imageFromtBeautyVC:UIImage?
    
    func beautyDidFinish(_ beautyVC:BeautyVC) {
        
        if beautyVC.image != nil {
            imageFromtBeautyVC = beautyVC.imageFromtBeautyVC
            frontImageView.image = imageFromtBeautyVC
            backImageView.image = imageFromtBeautyVC
        }else {
            
            frontImageView.image = beautyVC.frontImageView.image
        }
    }
    
    

    
    
    
}
