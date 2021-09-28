//
//  BirthdayScreenViewController.swift
//  birthday
//
//  Created by Jonas S on 23/09/2021.
//

import UIKit

class BirthdayScreenViewController: UIViewController, ImagePickerPresenting {
    
    @IBOutlet weak var birthdayTitleHead: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var superviewBabyImage: UIView!
    
    @IBOutlet weak var babyImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var ageImage: UIImageView!
    
    @IBOutlet weak var birthdayTitleTail: UILabel!
    
    var babyProfile: (name: String, age: Date, picture: UIImage?)?
    
    
    var cameraIcon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCameraIcon()
        
        let randomInt = Int.random(in: 1..<4)
        setTheme(themeNumber: randomInt)
        
        setBabyDetails()
        
    }
    
    func setBabyDetails() -> Void {
        
        setBirthOfDate()
        
        birthdayTitleHead.text = "TODAY \(babyProfile!.name.uppercased()) IS"
        
        if let imageBaby = babyProfile!.picture {
            babyImage.image = imageBaby
            babyImage.contentMode = .scaleToFill
            babyImage.layer.cornerRadius = 0.5 * babyImage.frame.height
        }
        
    }
    
    func setBirthOfDate() {
        let calendar = Calendar.current
        
        let todayDate = calendar.startOfDay(for: Date())
        let kidDateOfBirth = calendar.startOfDay(for: babyProfile!.age)
        
        let intervalDays = calendar.dateComponents([.day], from: kidDateOfBirth, to: todayDate)
        
        if intervalDays.day! < 31 {
            ageImage.image = UIImage(named: "0")
            birthdayTitleTail.text = "MONTH OLD"
        } else if (intervalDays.day! > 30 && intervalDays.day! < 365) {
            
            let intervalMonth = calendar.dateComponents([.month], from: kidDateOfBirth, to: todayDate)
            
            ageImage.image = UIImage(named: "\(intervalMonth.month!)")
            birthdayTitleTail.text = "MONTH(S) OLD"
        } else {
            let intervalYear = calendar.dateComponents([.year], from: kidDateOfBirth, to: todayDate)
            
            ageImage.image = UIImage(named: "\(intervalYear.year!)")
            birthdayTitleTail.text = "YEAR(S) OLD"
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //                babyImage.layer.cornerRadius = 0.5 * babyImage.frame.height
        
        cameraIcon.layoutIfNeeded()
        cameraIcon.layer.cornerRadius = 0.5 * cameraIcon.frame.height
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareScreenshot(_ sender: Any) {
        
        setItemHidden(isHidden: true)
        
        let renderer = UIGraphicsImageRenderer(size: view.frame.size)
        let image = renderer.image(actions: { context in
            view.layer.render(in: context.cgContext)
        })
        
        //        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        setItemHidden(isHidden: false)
        
        var imagesToShare = [AnyObject]()
        imagesToShare.append(image)
        
        let activityViewController = UIActivityViewController(activityItems: imagesToShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    func setItemHidden(isHidden: Bool) -> Void {
        backButton.isHidden = isHidden
        shareButton.isHidden = isHidden
        cameraIcon.isHidden = isHidden
    }
    
    @objc func pickImage(_ sender: Any) {
        
        presentImagePicker(completion: { [self] (image) in
            
            guard let validImage = image else {
                return
            }
            
            babyImage.contentMode = .scaleAspectFill
            babyImage.image = validImage
            babyImage.layer.cornerRadius = 0.5 * babyImage.frame.height
            
            // save image
            SetDetailsViewController.saveData(image: validImage)
        })
        
    }
    
    func setCameraIcon() -> Void {
        
        cameraIcon = UIImageView()
        cameraIcon.translatesAutoresizingMaskIntoConstraints = false
        cameraIcon.backgroundColor = .green
        superviewBabyImage.addSubview(cameraIcon)
        
        cameraIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cameraIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        let (hMult, vMult) = computeMultipliers(angle: 45)
        
        // position the little green circle using a multiplier on the right and bottom
        NSLayoutConstraint(item: cameraIcon!, attribute: .centerX, relatedBy: .equal, toItem: babyImage!, attribute: .trailing, multiplier: hMult, constant: 0).isActive = true
        NSLayoutConstraint(item: cameraIcon!, attribute: .centerY, relatedBy: .equal, toItem: babyImage!, attribute: .bottom, multiplier: vMult, constant: 0).isActive = true
        
        
        // add gesture recognizer to camera icon and make it clickable
        superviewBabyImage.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickImage(_:)))
        cameraIcon.addGestureRecognizer(gestureRecognizer)
        cameraIcon.isUserInteractionEnabled = true
        
        
    }
    
    func computeMultipliers(angle: CGFloat) -> (CGFloat, CGFloat) {
        let radians = angle * .pi / 180
        
        let h = (1.0 + cos(radians)) / 2
        let v = (1.0 - sin(radians)) / 2
        
        return (h, v)
    }
    
    func setTheme(themeNumber: Int) -> Void {
        switch themeNumber {
        case 1:
            backgroundImage.image = UIImage(named: "iOsBgElephant")
            babyImage.image = UIImage(named: "defaultPlaceHolderYellow")
            cameraIcon.image = UIImage(named: "cameraIconYellow")
            
            
            break
        case 2:
            backgroundImage.image = UIImage(named: "iOsBgFox")
            babyImage.image = UIImage(named: "defaultPlaceHolderGreen")
            cameraIcon.image = UIImage(named: "cameraIconGreen")
            
            
            break
        case 3:
            backgroundImage.image = UIImage(named: "iOsBgPelican2")
            babyImage.image = UIImage(named: "defaultPlaceHolderBlue")
            cameraIcon.image = UIImage(named: "cameraIconBlue")
            
            
            
            break
        default:
            break
        }
    }
    
    
    /*
     MARK: - Navigation
     
     In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     Get the new view controller using segue.destination.
     Pass the selected object to the new view controller.
     }
     */
    
}
