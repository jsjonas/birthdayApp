//
//  BirthdayScreenViewController.swift
//  birthday
//
//  Created by Jonas S on 23/09/2021.
//

import UIKit

class BirthdayScreenViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "iOsBgElephant")!)
        setTheme(themeNumber: 1)
        // Do any additional setup after loading the view.
    }
    
    func setTheme(themeNumber: Int) -> Void {
        switch themeNumber {
        case 1:
            backgroundImage.image = UIImage(named: "iOsBgElephant")
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
