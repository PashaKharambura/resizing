
//
//  ViewController.swift
//  resizingImages
//
//  Created by Pavlo Kharambura on 9/14/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cropButton: UIButton!
    
    var newImages = [UIImage]()
    var dataImages = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: EMAIL
    
    func configureMailComtroller() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["pasha.harambura@gmail.com"])
        mailComposerVC.setSubject("image")
        mailComposerVC.setMessageBody("body", isHTML: false)
        
        for image in newImages {
            dataImages.append(UIImagePNGRepresentation(image)!)
        }
        
        for data in dataImages {
            var counter = 1
            mailComposerVC.addAttachmentData(data, mimeType: "\(counter)/png", fileName: "\(counter).png")
            counter += 1
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
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = image
        dismiss(animated:true, completion: nil)
    }
    
    // MARK: Cropping Images
    
    func croppingImages(image: UIImage, width: Double, height: Double) {
        let newImage = image.resizedImage(newSize: CGSize(width: width, height: height))
        self.newImages.append(newImage)
    }

    @IBAction func cropAction(_ sender: Any) {
        croppingImages(image: imageView.image!, width: 30, height: 30)
        croppingImages(image: imageView.image!, width: 50, height: 50)
        
    }
    
}
