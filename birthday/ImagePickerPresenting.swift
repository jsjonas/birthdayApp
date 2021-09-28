//
//  ImagePickerPresenting.swift
//  birthday
//
//  Created by Jonas S on 28/09/2021.
//

import Foundation

import UIKit
import AVFoundation
import Photos

private var completionBlock: ((UIImage?) -> Void)?

protocol ImagePickerPresenting: ImagePickerControllerDelegate {
    func presentImagePicker(completion: @escaping (UIImage?) -> Void)
}

extension ImagePickerPresenting where Self: UIViewController {
    
    func presentImagePicker(completion: @escaping (UIImage?) -> Void) {
        
        completionBlock = completion
        let imagePickerViewController = ImagePickerController()
        imagePickerViewController.imagePickerDelegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerViewController.sourceType = .camera
            imagePickerViewController.cameraDevice = .rear
            imagePickerViewController.cameraCaptureMode = .photo
            imagePickerViewController.showsCameraControls = true
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Take Photo", style: .default) { (action) in
                imagePickerViewController.sourceType = .camera
                
                imagePickerViewController.allowsEditing = true
                imagePickerViewController.imagePickerDelegate = self
                self.present(imagePickerViewController, animated: true, completion: nil)

                
            }
            let gallery = UIAlertAction(title: "Choose Photo", style: .default) { (action) in
                imagePickerViewController.sourceType = .photoLibrary
                imagePickerViewController.imagePickerDelegate = self
                imagePickerViewController.allowsEditing = true

                self.present(imagePickerViewController, animated: true, completion: nil)

            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                completionBlock = nil
            }
            
            actionSheet.addAction(camera)
            actionSheet.addAction(gallery)
            actionSheet.addAction(cancelAction)
            self.present(actionSheet, animated: true, completion: nil)
        } else {
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.imagePickerDelegate = self
            imagePickerViewController.isNavigationBarHidden = false
            imagePickerViewController.isToolbarHidden = true
            self.present(imagePickerViewController, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidFinish(image: UIImage?, _ viewController: ImagePickerController) {
        
        completionBlock?(image)
        completionBlock = nil
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
