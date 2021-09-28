//
//  ViewController.swift
//  birthday
//
//  Created by Jonas S on 22/09/2021.
//

import UIKit

class SetDetailsViewController: UIViewController, ImagePickerPresenting {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var pictureButton: UIButton!
    
    @IBOutlet weak var birthDate: UIDatePicker!
    
    @IBOutlet weak var name: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    static let profilePngString = "profile.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setBabyProfileIfExist()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    @IBAction func showBirthdayScreenBtn(_ sender: Any) {
        
        if name.hasText && birthDate.date < Date() {
            performSegue(withIdentifier: "fromSetDetailsSegue", sender: self)
            
        } else {
            let alert = UIAlertController(title: "Empty Fields", message: "Please fill the baby name and upload the baby picture", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil
            ))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
    @IBAction func takePictureBtn(_ sender: Any) {
        
        presentImagePicker(completion: { (image) in
            
            guard let validImage = image else {
                return
            }
            
            self.profileImage.image = validImage
            SetDetailsViewController.saveData(image: validImage)
        })
        
        
    }
    
    func setBabyProfileIfExist() -> Void {
        if let image = loadJpeg(fileName: SetDetailsViewController.profilePngString) {
            profileImage.image = image
        }
        
        if let date = UserDefaults.standard.object(forKey: "date_birth") as? Date {
            let df = DateFormatter()
            df.dateFormat = "dd/MM/yyyy"
            birthDate.date = date
            print(df.string(from: date))
        } else {
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
            birthDate.date = tomorrow!
        }
        
        if let nameString = UserDefaults.standard.object(forKey: "name") as? String {
            name.text = nameString
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BirthdayScreenViewController {
            let kid = (name.text!, birthDate.date, profileImage.image)
            
            vc.babyProfile = kid

            
        }
    }
    
    static func saveData(image: UIImage) -> Void {
        if let data = image.pngData() {
            let filename = SetDetailsViewController.getDocumentsDirectory().appendingPathComponent(profilePngString)
            try? data.write(to: filename)
        }
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadJpeg(fileName: String) -> UIImage? {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
}


