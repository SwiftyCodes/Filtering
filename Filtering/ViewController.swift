//
//  ViewController.swift
//  Filtering
//
//  Created by Polak on 5/26/17.
//  Copyright © 2017 Polak. All rights reserved.
//

import UIKit
import GPUImage
import Photos



class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var filterScrollView: UIScrollView!
    @IBOutlet weak var frontback: UIButton!
    
    
    var stillCamera : GPUImageStillCamera!
    var image : GPUImageView!
    var GpuFilter : GPUImageFilter!
    
    var picker:UIImagePickerController?=UIImagePickerController()
    
    let tapRenderView = UITapGestureRecognizer()
    
      var FilterArrayImages = ["toon","cruz","hue2","solarize","gray","sepia2","nomad","pixelate","marid","dotted","amatorka","sketch","bilateral","iris","poster","dilate","lincolun","market","oak","fairy"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeCamera()
        self.filterScrollView.isHidden = true
        creation()
        
        tapRenderView.addTarget(self, action: #selector(ViewController.toHideScrollViewFilter))
        image.addGestureRecognizer(tapRenderView)
        
    }
  
    func initializeCamera() {
        
        stillCamera = GPUImageStillCamera(sessionPreset: AVCaptureSessionPresetPhoto, cameraPosition: .back)
        
        stillCamera.outputImageOrientation = .portrait
        image = GPUImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        GpuFilter = GPUImageSaturationFilter()
        
        self.view.addSubview(image)
        
        self.view.bringSubview(toFront: captureButton)
        self.view.bringSubview(toFront: filterButton)
        self.view.bringSubview(toFront: galleryButton)
        self.view.bringSubview(toFront: filterScrollView)
        self.view.bringSubview(toFront: frontback)
        
        stillCamera.addTarget(GpuFilter)
        GpuFilter.addTarget(image)
        stillCamera.startCapture()
        
    }

    var itemCount : Int?
    func creation() {
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 55.0
        let buttonHeight: CGFloat = 55.0
        let gapBetweenButtons: CGFloat = 5
        var itemCount = 0
        
//        let subViews = self.filterScrollView.subviews
//        for subview in subViews{
//            subview.removeFromSuperview()
//        }
        
        filterScrollView.translatesAutoresizingMaskIntoConstraints = false
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
            filterScrollView.addSubview(filterButton)
            
        }
        filterScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+3), height: yCoord)
    }
    
    //MARK: Combining Filters
 
    var filterItem : Int?
    func FilterTapped(sender: UIButton) {
        let button = sender as UIButton
        filterItem = button.tag
        switch button.tag {
            
        case 0:
            
            print("TOON Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageToonFilter()
            stillCamera.addTarget(GpuFilter)
            self.GpuFilter.addTarget(self.image)
    
        case 1:
            
     
            print("Etikete Filter Applied")
            stillCamera.removeAllTargets()
            let Etikate = GPUImageMissEtikateFilter()
            stillCamera.addTarget(Etikate)
            Etikate.addTarget(image)
            
        case 2:
            
            
            print("Hue Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageHueFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(image)
            
        case 3:
            
            
            print("Solarize Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageSolarizeFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(image)
            
        case 4:
            
            print("Gray SCALE Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageGrayscaleFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(image)
            
        case 5:
            
            print("Sepia Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageSepiaFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(image)


        case 6:
            
  
            
            print("Gray TOON Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageToonFilter()
            let  GrayGpuFilter = GPUImageGrayscaleFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(GrayGpuFilter)
            GrayGpuFilter.addTarget(image)
            
        case 7:
            
            print("Pixellate Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImagePixellateFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(image)
            
        case 8:

            
            print("Amatorka TOON Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageToonFilter()
            let  AmatorkaGpuFilter = GPUImageAmatorkaFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(AmatorkaGpuFilter)
            AmatorkaGpuFilter.addTarget(image)
            
        case 9:

            stillCamera.removeAllTargets()
            let PolkaFilter = GPUImagePolkaDotFilter()
            PolkaFilter.fractionalWidthOfAPixel = 0.005
            stillCamera.addTarget(PolkaFilter)
            PolkaFilter.addTarget(image)

        case 10:
            
            print("AmatorkaFilter Filter Applied")
            stillCamera.removeAllTargets()
            let amtFilter = GPUImageAmatorkaFilter()
            // GpuFilter = GPUImageAmatorkaFilter()
            stillCamera.addTarget(amtFilter)
            amtFilter.addTarget(image)
 
            
        case 11:

            print("Sketch Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageSketchFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(image)
            
        case 12:
           
            print("Biletral Filter Applied")
            stillCamera.removeAllTargets()
            let biletralFilter = GPUImageBilateralFilter()
            biletralFilter.texelSpacingMultiplier = 10.0
            biletralFilter.distanceNormalizationFactor = 4.0
            stillCamera.addTarget(biletralFilter)
            biletralFilter.addTarget(image)
            
        case 13:
     
            
            print("Etikete TOON Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageToonFilter()
            let  EtikateGpuFilter = GPUImageMissEtikateFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(EtikateGpuFilter)
            EtikateGpuFilter.addTarget(image)
            
        case 14:
            
            print("PolkaDot Filter Applied")
            // polkaDot.fractionalWidthOfAPixel = 0.005
            
            stillCamera.removeAllTargets()
            GpuFilter = GPUImagePosterizeFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(image)
           
            
        case 15:
   
            print("Dilation Filter Applied")
           // dilation.radius = 5
            
            stillCamera.removeAllTargets()
            let dilationFilter = GPUImageDilationFilter()
            //            GpuFilter = GPUImagePolkaDotFilter()
          
            stillCamera.addTarget(dilationFilter)
            dilationFilter.addTarget(image)
            
        case 16:
            
            print("Hue TOON Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageToonFilter()
            let  HueGpuFilter = GPUImageHueFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(HueGpuFilter)
            HueGpuFilter.addTarget(image)
            
        case 17:
            
            print("Sepia Amotorka Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageSepiaFilter()
            let  AmatorkaGpuFilter = GPUImageAmatorkaFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(AmatorkaGpuFilter)
            AmatorkaGpuFilter.addTarget(image)
            
        case 18:
            
            print("Sepia Toon Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageToonFilter()
            let  SepiaGpuFilter = GPUImageSepiaFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(SepiaGpuFilter)
            SepiaGpuFilter.addTarget(image)
            
        case 19:
        
            print("Sepia Etikete Filter Applied")
            stillCamera.removeAllTargets()
            GpuFilter = GPUImageSepiaFilter()
            let  EtikateGpuFilter = GPUImageMissEtikateFilter()
            stillCamera.addTarget(GpuFilter)
            GpuFilter.addTarget(EtikateGpuFilter)
            EtikateGpuFilter.addTarget(image)
            
        default:
            break
        }
    }
    
    func toHideScrollViewFilter() {
        UIView.transition(with: filterScrollView, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
            self.filterScrollView.isHidden = true
        }, completion: { _ in })
        
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
     print("Filter is pressed")
        
        UIView.transition(with: filterScrollView, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
            self.filterScrollView.isHidden = false
        }, completion: { _ in })
        
    }
    
    var cameraToggle = false

    @IBAction func frontBackCameraAction(_ sender: UIButton) {
        
        if cameraToggle {
            
            UIView.transition(with: image, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
                self.stillCamera.rotateCamera()
                 self.frontback.setImage(UIImage(named:"back-camera"), for: .normal)
            }, completion: { _ in })
            
        }else {
            
            UIView.transition(with: image, duration: 0.4, options: .transitionCrossDissolve, animations: {() -> Void in
                self.stillCamera.rotateCamera()
                 self.frontback.setImage(UIImage(named:"front-camera"), for: .normal)
            }, completion: { _ in })
            
        }

                
      cameraToggle = !cameraToggle

        
    }
    
    @IBAction func captureButton (_ sender:UIButton) {
       
      let imageTobeSent = screenshot()
        
      //  UIImageWriteToSavedPhotosAlbum(screenshot(), self, nil, nil)
        let vc: TuneToolsVC? = self.storyboard?.instantiateViewController(withIdentifier: "TuneToolsVC") as? TuneToolsVC
        
        vc?.imageFromCameraVC = imageTobeSent
        
        self.present(vc!, animated: true, completion: nil)
 
        
    }
    
    @IBAction func galleryButtonAction(_ sender: UIButton) {
        
        openGallary()
    }
    func openGallary()
    {
        
        picker?.delegate=self
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let galleryImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        let vc: TuneToolsVC? = self.storyboard?.instantiateViewController(withIdentifier: "TuneToolsVC") as? TuneToolsVC
        
        if let validVC: TuneToolsVC = vc {
            if let capturedImage = galleryImage {
                validVC.imageFromCameraVC = capturedImage
                DispatchQueue.main.async
                    {
            self.present(validVC, animated: true, completion: nil)
                }
                
            }
            
        }

        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

    
    func screenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.image.bounds.size, false, UIScreen.main.scale)
        self.image.drawHierarchy(in: self.image.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }


}

