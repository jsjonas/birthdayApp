//
//  ImgViewConroller.swift
//  birthday
//
//  Created by Jonas S on 28/09/2021.
//

import Foundation
import UIKit

protocol ImagePickerControllerDelegate: AnyObject {
    func imagePickerControllerDidFinish(image: UIImage?, _: ImagePickerController)
}


final  class ImagePickerController: UIImagePickerController {
    weak var imagePickerDelegate: ImagePickerControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ImagePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imagePickerDelegate?.imagePickerControllerDidFinish(image: pickedImage, self)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerDelegate?.imagePickerControllerDidFinish(image: nil, self)
    }
}
