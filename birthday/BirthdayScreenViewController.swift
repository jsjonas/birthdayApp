//
//  BirthdayScreenViewController.swift
//  birthday
//
//  Created by Jonas S on 23/09/2021.
//

import UIKit

class BirthdayScreenViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var babyImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    var cameraIcon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPhotoIcon()
        
        //        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "iOsBgElephant")!)
        let randomInt = Int.random(in: 1..<4)
        
        setTheme(themeNumber: randomInt)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        babyImage.layer.cornerRadius = 0.5 * babyImage.frame.height
        
        cameraIcon.layoutIfNeeded()
        cameraIcon.layer.cornerRadius = 0.5 * cameraIcon.frame.height
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareScreenshot(_ sender: Any) {
        
        setItemHidden(isHidden: true)
        //Create the UIImage
        let renderer = UIGraphicsImageRenderer(size: view.frame.size)
        let image = renderer.image(actions: { context in
            view.layer.render(in: context.cgContext)
        })
        
        //Save it to the camera roll
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
    
    func setPhotoIcon() -> Void {
        cameraIcon = UIImageView()
        cameraIcon.translatesAutoresizingMaskIntoConstraints = false
        cameraIcon.backgroundColor = .green
        babyImage.addSubview(cameraIcon)
        
        cameraIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cameraIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        let (hMult, vMult) = computeMultipliers(angle: 45)
        
        // position the little green circle using a multiplier on the right and bottom
        NSLayoutConstraint(item: cameraIcon!, attribute: .centerX, relatedBy: .equal, toItem: babyImage!, attribute: .trailing, multiplier: hMult, constant: 0).isActive = true
        NSLayoutConstraint(item: cameraIcon!, attribute: .centerY, relatedBy: .equal, toItem: babyImage!, attribute: .bottom, multiplier: vMult, constant: 0).isActive = true
        
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
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
