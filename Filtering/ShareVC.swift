import UIKit
import Social
import MessageUI
import AVFoundation

class ShareVC: UIViewController,UINavigationControllerDelegate,MFMailComposeViewControllerDelegate {

    var image : UIImage!
    
    @IBOutlet weak var frontImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontImageView.frame = AVMakeRect(aspectRatio: (image?.size)!, insideRect: frontImageView.bounds)
        frontImageView.image = image

        
    }

    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
     self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        
        let vc: ViewController? = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func commonButtonAction(_ sender: UIButton) {
        
        let screen = UIScreen.main
        
        switch sender
        .tag{
            
        case 1:
            print("FaceBook")
            
            if let window = UIApplication.shared.keyWindow {
                UIGraphicsBeginImageContextWithOptions(screen.bounds.size, false, 0);
                window.drawHierarchy(in: window.bounds, afterScreenUpdates: false)
                let image = frontImageView.image!
                UIGraphicsEndImageContext();
                
                let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                composeSheet?.setInitialText("Hello, Facebook!")
                composeSheet?.add(image)
                present(composeSheet!, animated: true, completion: nil)
            }
            
        case 2:
            print("Twitter")
            
            let screen = UIScreen.main
            
            if let window = UIApplication.shared.keyWindow {
                UIGraphicsBeginImageContextWithOptions(screen.bounds.size, false, 0);
                window.drawHierarchy(in: window.bounds, afterScreenUpdates: false)
                let image = frontImageView.image!
                UIGraphicsEndImageContext();
                
                let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                composeSheet?.setInitialText("Hello, Twitter!")
                composeSheet?.add(image)
                present(composeSheet!, animated: true, completion: nil)
            }
            
        case 3:
            print("Insta")
            
             InstagramManager.sharedManager.postImageToInstagramWithCaption(imageInstagram: frontImageView.image!, instagramCaption: "\(self.description)", view: self.view)
            
        case 4:
            print("Mail")
            sendMail(imageView: frontImageView)
            
        case 5:
            print("Gallery")
            
            UIImageWriteToSavedPhotosAlbum(frontImageView.image!, nil, nil, nil)
            
            _ = SweetAlert().showAlert("Alert", subTitle: "Your image has been saved to the gallery.", style: AlertStyle.success)
            
        case 6:
            
            print("Others")
            sharePhoto()
      
        default:
            break
        }
        
    }
    
    //MARK: Sending Mail
    func sendMail(imageView: UIImageView) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Your messagge")
            mail.setMessageBody("Message body", isHTML: false)
            let imageData: NSData = UIImagePNGRepresentation(imageView.image!)! as NSData
            mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "imageName")
            self.present(mail, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Share
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
    

}
