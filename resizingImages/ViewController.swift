
//
//  ViewController.swift
//  resizingImages
//
//  Created by Pavlo Kharambura on 9/14/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit
import MessageUI
import GoogleMobileAds

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cropButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var openLibtraryButton: UIButton!
    @IBOutlet weak var libraryDone: UIImageView!
    @IBOutlet weak var croppingDone: UIImageView!
    @IBOutlet weak var adBanner: UIView!
    
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!

    var newImages = [UIImage]()
    var dataImages = [Data]()
    var counter = 1
    var dataNumber = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // звичайний банер
        
        bannerView = GADBannerView(adSize: kGADAdSizeFullBanner)
        self.view.addSubview(bannerView)
        bannerView.adUnitID = "ca-app-pub-2747619443241513/6366999120"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self

        // Рекламка на всю сторінку
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-2747619443241513/7806582614")
        let request = GADRequest()
        interstitial.load(request)
        
        
        libraryDone.alpha = 0
        croppingDone.alpha = 0
        
        emailTextField.delegate = self
        
        sendButton.layer.cornerRadius = 25
        cropButton.layer.cornerRadius = 20
        openLibtraryButton.layer.cornerRadius = 20
    
        sendButton.isEnabled = false
        cropButton.isEnabled = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil) 
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        perfornAction()
    }
    
    func perfornAction() {
        if emailTextField.text != "" && imageView.image != nil {
            sendButton.isEnabled = true
        }
    }
    
    // MARK: EMAIL
    
    func configureMailComtroller() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        let email = self.emailTextField.text
        mailComposerVC.setToRecipients([email!])
        mailComposerVC.setSubject("Icons For IOS App")        
        for image in newImages {
            dataImages.append(UIImagePNGRepresentation(image)!)
        }
        for data in dataImages {
          
            let dataAmount = dataImages.count

            if dataNumber <= 3 {
                mailComposerVC.addAttachmentData(data, mimeType: "Icon/png", fileName: "App-Icon-20x20@\(counter)x.png")
                counter = counter + 1
                dataNumber = dataNumber + 1
                if counter == 4 {
                    counter = 1
                }
            } else if (dataNumber <= 6 && dataNumber > 3) {
                mailComposerVC.addAttachmentData(data, mimeType: "Icon/png", fileName: "App-Icon-29x29@\(counter)x.png")
                counter = counter + 1
                dataNumber = dataNumber + 1
                if counter == 4 {
                    counter = 1
                }
            } else if (dataNumber <= 9 && dataNumber > 6) {
                mailComposerVC.addAttachmentData(data, mimeType: "Icon/png", fileName: "App-Icon-40x40@\(counter)x.png")
                counter = counter + 1
                dataNumber = dataNumber + 1
                if counter == 4 {
                    counter = 1
                }
            } else if (dataNumber <= 12 && dataNumber > 9) {
                mailComposerVC.addAttachmentData(data, mimeType: "Icon/png", fileName: "App-Icon-60x60@\(counter)x.png")
                counter = counter + 1
                dataNumber = dataNumber + 1
                if counter == 4 {
                    counter = 1
                }
            } else if (dataNumber <= 15 && dataNumber > 12) {
                mailComposerVC.addAttachmentData(data, mimeType: "Icon/png", fileName: "App-Icon-76x76@\(counter)x.png")
                counter = counter + 1
                dataNumber = dataNumber + 1
                if counter == 4 {
                    counter = 1
                }
            } else if (dataNumber <= 17 && dataNumber > 15) {
                mailComposerVC.addAttachmentData(data, mimeType: "Icon/png", fileName: "App-Icon-57x57@\(counter)x.png")
                counter = counter + 1
                dataNumber = dataNumber + 1
                if counter == 3 {
                    counter = 1
                }
            } else if (dataNumber <= 19 && dataNumber > 17) {
                mailComposerVC.addAttachmentData(data, mimeType: "Icon/png", fileName: "App-Icon-72x72@\(counter)x.png")
                counter = counter + 1
                dataNumber = dataNumber + 1
                if counter == 3 {
                    counter = 1
                }
            } else if (dataNumber <= 21 && dataNumber > 19) {
                mailComposerVC.addAttachmentData(data, mimeType: "Icon/png", fileName: "App-Icon-50x50@\(counter)x.png")
                counter = counter + 1
                dataNumber = dataNumber + 1
                if counter == 3 {
                    counter = 1
                }
            } else if dataNumber > 21 && dataNumber <= 22 {
                mailComposerVC.addAttachmentData(data, mimeType: "Icon/png", fileName: "App-Icon-83.5x83.5@2x.png")
                counter = counter + 1
                dataNumber = dataNumber + 1
            } else if dataNumber > 22 && dataNumber <= dataAmount {
                mailComposerVC.addAttachmentData(data, mimeType: "Icon/png", fileName: "AppIcon-1024.png")
            }
        }
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
        imageView.image = nil
        sendButton.isEnabled = false
        cropButton.isEnabled = false
        croppingDone.alpha = 0
        libraryDone.alpha = 0
        emailTextField.text = ""
        dataImages = []
        newImages = []
        // ad
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        let mailComposerViewConroller = configureMailComtroller()
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposerViewConroller, animated: true, completion: nil)
        } else {
            print("ERROR")
        }
    }

    // MARK: Cropping Images
    
    func croppingImages(image: UIImage, width: Double, height: Double) {
        let newImage = image.resizedImage(newSize: CGSize(width: width, height: height))
        self.newImages.append(newImage)
    }
    
    @IBAction func cropAction(_ sender: Any) {
        SwiftSpinner.show("Making Icons")
        /// 20
        croppingImages(image: imageView.image!, width: 10, height: 10)
        croppingImages(image: imageView.image!, width: 20, height: 20)
        croppingImages(image: imageView.image!, width: 30, height: 30)
        /// 29
        croppingImages(image: imageView.image!, width: 14.5, height: 14.5)
        croppingImages(image: imageView.image!, width: 29, height: 29)
        croppingImages(image: imageView.image!, width: 43.5, height: 43.5)
        /// 40
        croppingImages(image: imageView.image!, width: 20, height: 20)
        croppingImages(image: imageView.image!, width: 40, height: 40)
        croppingImages(image: imageView.image!, width: 60, height: 60)
        /// 60
        croppingImages(image: imageView.image!, width: 30, height: 30)
        croppingImages(image: imageView.image!, width: 60, height: 60)
        croppingImages(image: imageView.image!, width: 90, height: 90)
        /// 76
        croppingImages(image: imageView.image!, width: 38, height: 38)
        croppingImages(image: imageView.image!, width: 76, height: 76)
        croppingImages(image: imageView.image!, width: 114, height: 114)
        /// 57
        croppingImages(image: imageView.image!, width: 28.5, height: 28.5)
        croppingImages(image: imageView.image!, width: 57, height: 57)
        /// 72
        croppingImages(image: imageView.image!, width: 36, height: 36)
        croppingImages(image: imageView.image!, width: 72, height: 72)
        /// small 50
        croppingImages(image: imageView.image!, width: 25, height: 25)
        croppingImages(image: imageView.image!, width: 50, height: 50)
        /// 83.5 @2x
        croppingImages(image: imageView.image!, width: 83.5, height: 83.5)
        /// 1024
        croppingImages(image: imageView.image!, width: 512, height: 512)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            SwiftSpinner.hide()
            self.cropButton.isEnabled = false
            self.croppingDone.alpha = 1
        }
    }
    
    // MARK: Open Pgoto Library
    
    @IBAction func openLibrary(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        self.imageView.image = image
        dismiss(animated:true, completion: nil)
        cropButton.isEnabled = true
        libraryDone.alpha = 1
    }
   
    // MARK: Move View
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}
