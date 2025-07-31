//
//  GroupMenuContext.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 19.6.2023.
//

import CropViewController
import UIKit



extension CreateGroupInfoVC: GroupCreationMessageDisapearSheet {
    
    func showOptionActionSheet() {
        
        let alertController = UIAlertController(title:Language.automatically_disapear_messages_in_this_group_after_period_of_time, message: nil, preferredStyle: .actionSheet)
        

        let action1 = UIAlertAction(title: Language.off, style: .destructive) { _ in
            self.option = .off
            if let unwrapedHeaderView = self.headerView {
                unwrapedHeaderView.optionText.text = Language.off
            }
            
        }
        let action2 = UIAlertAction(title: Language.twenty_four_hours, style: .default) { _ in
            self.option = .twenty4hours
            if let unwrapedHeaderView = self.headerView {
                unwrapedHeaderView.optionText.text = Language.twenty_four_hours
            }
        }
        let action3 = UIAlertAction(title: Language.seven_days, style: .default) { _ in
            self.option = .sevendays
            if let unwrapedHeaderView = self.headerView {
                unwrapedHeaderView.optionText.text = Language.seven_days
            }
            // Handle Action 2
        }
        let action4 = UIAlertAction(title: Language.thirty_days, style: .default) { _ in
            self.option = .thirtydays
            if let unwrapedHeaderView = self.headerView {
                unwrapedHeaderView.optionText.text = Language.thirty_days
            }
            // Handle Action 2
        }
        let cancelAction = UIAlertAction(title: Language.cancel, style: .cancel) { _ in
            // Handle Cancel action
        }

        
        alertController.addAction(action2)
        alertController.addAction(action3)
        alertController.addAction(action4)
        alertController.addAction(action1)
        alertController.addAction(cancelAction)

        if let popoverPresentationController = alertController.popoverPresentationController {
            // Set the source view or bar button item to anchor the action sheet on iPad
            popoverPresentationController.sourceView = view // Replace "view" with your desired source view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = [] // Remove the arrow on iPad
        }

        present(alertController, animated: true, completion: nil)
    }
    
}





extension CreateGroupInfoVC: GroupCreationPhotoSheet, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
    
    
    
    func showPhotoActionSheet() {
        
        if let unwrapedHeaderView = self.headerView {
            unwrapedHeaderView.nameTextField.resignFirstResponder()
        }
        
        
        // Create an image picker controller
           let imagePicker = UIImagePickerController()
            //
            //        let overlayView = UIView(frame: CGRect(x: 0, y: 0, width: imagePicker.view.bounds.width, height: imagePicker.view.bounds.height))
            ////        overlayView.backgroundColor = .clear
            //
            //        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: overlayView.bounds.width, height: overlayView.bounds.height))
            //        let maskLayer = CAShapeLayer()
            //        maskLayer.path = circlePath.cgPath
            //        maskLayer.fillColor = UIColor.black.cgColor
            //        maskLayer.fillRule = .evenOdd
            //        overlayView.layer.mask = maskLayer
            //
            //        imagePicker.cameraOverlayView = overlayView
        
        
        
        let alertController = UIAlertController(title:Language.automatically_disapear_messages_in_this_group_after_period_of_time, message: nil, preferredStyle: .actionSheet)
        

        let action1 = UIAlertAction(title: Language.open_camera, style: .default) { _ in
            
            if let unwrapedHeaderView = self.headerView {
                unwrapedHeaderView.nameTextField.resignFirstResponder()
            }

               imagePicker.sourceType = .camera
               imagePicker.delegate = self
               imagePicker.allowsEditing = true
            
           // Present the image picker
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        let action2 = UIAlertAction(title: Language.choose_image, style: .default) { _ in
            
            if let unwrapedHeaderView = self.headerView {
                unwrapedHeaderView.nameTextField.resignFirstResponder()
            }
            let imagePicker = UIImagePickerController()
            
            imagePicker.sourceType = .photoLibrary // or .savedPhotosAlbum
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        let action3 = UIAlertAction(title: Language.emoji_image, style: .default) { _ in
            
            
            // Handle Action 2
        }
        let action4 = UIAlertAction(title: Language.search_web, style: .default) { _ in
            // Handle Action 2
            
        }
        let cancelAction = UIAlertAction(title: Language.cancel, style: .cancel) { _ in
            // Handle Cancel action
        }
    

        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        alertController.addAction(action4)
        alertController.addAction(cancelAction)

        if let popoverPresentationController = alertController.popoverPresentationController {
            // Set the source view or bar button item to anchor the action sheet on iPad
            popoverPresentationController.sourceView = view // Replace "view" with your desired source view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = [] // Remove the arrow on iPad
        }

        present(alertController, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true) {
//            if let cropViewController = self.presentedViewController as? CropViewController {
//                cropViewController.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)

            if let image = info[.originalImage] as? UIImage {
                
//                if let unwrapedHeaderView = headerView {
//                    unwrapedHeaderView.groupImage.image = image
//                }
                picker.dismiss(animated: true, completion: nil)
                cropImage(image: image)
            }
        
        }
    
    func cropImage(image: UIImage) {
        let vc = CropViewController(croppingStyle: .circular, image: image)
//        vc.aspectRatioPreset = .presetSquare
//        vc.aspectRatioLockEnabled = false
    
        vc.delegate = self
        vc.doneButtonColor = AppTheme.primaryColor
        
        
        
//        vc.cancelButtonColor = .red
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: false, completion: nil)
    }
    
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        if let unwrapedHeaderView = headerView {
            unwrapedHeaderView.groupImage.image = image
            unwrapedHeaderView.groupImage.layer.zPosition = 2
        }
        
        cropViewController.dismiss(animated: false, completion: nil)
    }
    
    
    
    
    
}
