//
//  PersonalViewController.swift
//  CT.0
//
//  Created by Nathan Maglasang on 22/6/2024.
//

import UIKit

class PersonalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        heighttxt.placeholder = "\(AppData.shared.height)"
        weighttxt.placeholder = "\(AppData.shared.weight)"
        agetxt.placeholder = "\(AppData.shared.age)"


        // Do any additional setup after loading the view.
    }
        //need to do custom calorie set and calc new cals

    @IBAction func surveyagain(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Survey", bundle: nil)
        let newViewController = storyboard.instantiateInitialViewController()
        
        if let newViewController = newViewController {
            newViewController.modalPresentationStyle = .fullScreen
            present(newViewController, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var weighttxt: UITextField!
    @IBOutlet weak var heighttxt: UITextField!
    @IBOutlet weak var agetxt: UITextField!
    @IBOutlet weak var exit: UIButton!
    
    @IBAction func Updtatecust(_ sender: UIButton) {
        
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
