
//
//  ViewController.swift
//  resizingImages
//
//  Created by Pavlo Kharambura on 9/14/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cropButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var openLibtraryButton: UIButton!
    
    var newImages = [UIImage]()
    var dataImages = [Data]()
    var counter = 1
    var dataNumber = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.delegate = self
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
        if emailTextField.text != "" {
            sendButton.isEnabled = true
        }
    }
    
    // MARK: EMAIL
    
    func configureMailComtroller() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        let email = self.emailTextField.text
        mailComposerVC.setToRecipients([email!])
        mailComposerVC.setSubject("image")
        mailComposerVC.setMessageBody("body", isHTML: false)
        
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
            } else if dataNumber > 21 && dataNumber <= dataAmount {
                mailComposerVC.addAttachmentData(data, mimeType: "Icon/png", fileName: "App-Icon-83.5x83.5@2x.png")
            }
        }
        return mailComposerVC
    }
        
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
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
        /// 20
        croppingImages(image: imageView.image!, width: 20, height: 20)
        croppingImages(image: imageView.image!, width: 40, height: 40)
        croppingImages(image: imageView.image!, width: 60, height: 60)
        /// 29
        croppingImages(image: imageView.image!, width: 29, height: 29)
        croppingImages(image: imageView.image!, width: 58, height: 58)
        croppingImages(image: imageView.image!, width: 87, height: 87)
        /// 40
        croppingImages(image: imageView.image!, width: 40, height: 40)
        croppingImages(image: imageView.image!, width: 80, height: 80)
        croppingImages(image: imageView.image!, width: 120, height: 120)
        /// 60
        croppingImages(image: imageView.image!, width: 60, height: 60)
        croppingImages(image: imageView.image!, width: 120, height: 120)
        croppingImages(image: imageView.image!, width: 180, height: 180)
        /// 76
        croppingImages(image: imageView.image!, width: 76, height: 76)
        croppingImages(image: imageView.image!, width: 152, height: 152)
        croppingImages(image: imageView.image!, width: 228, height: 228)
        /// 57
        croppingImages(image: imageView.image!, width: 57, height: 57)
        croppingImages(image: imageView.image!, width: 114, height: 114)
        /// 72
        croppingImages(image: imageView.image!, width: 72, height: 72)
        croppingImages(image: imageView.image!, width: 144, height: 144)
        /// small 50
        croppingImages(image: imageView.image!, width: 50, height: 50)
        croppingImages(image: imageView.image!, width: 100, height: 100)
        /// 83.5 @2x
        croppingImages(image: imageView.image!, width: 167, height: 167)
        
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
    }
   
    // MARK: Move View
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
}
