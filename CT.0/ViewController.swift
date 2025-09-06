import UIKit
import Foundation


var progress: Float = 0
var progressw: Float = 0
var progressp: Float = 0

class ViewController: UIViewController {
    var maxcalset = true
    var originalButtonYPosition: CGFloat = 0.0
    var originalButton2YPosition: CGFloat = 0.0
    var kbdusd = false
    
    @IBOutlet weak var selector: UISegmentedControl!
    @IBOutlet weak var waterprogress: UIProgressView!
    @IBOutlet weak var proteinmax: UIButton!
    @IBOutlet weak var proteinprogress: UIProgressView!
    @IBOutlet weak var watermax: UIButton!
    @IBOutlet weak var calmax: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        calmax.setTitle("\(AppData.shared.setmax)", for: .normal)
        watermax.setTitle("\(AppData.shared.watermax) L", for: .normal)
        proteinmax.setTitle("\(AppData.shared.proteinmax) g", for: .normal)

     
        if AppData.shared.calories > AppData.shared.setmax {
            AppData.shared.progress = 1.0
        } else {
            AppData.shared.progress = Float(AppData.shared.calories) / Float(AppData.shared.setmax)
        }
        if AppData.shared.water > AppData.shared.watermax {
            progressw = 1.0
        } else {
           
        }
        if AppData.shared.protein > AppData.shared.proteinmax {
                progressp = 1.0
        } else {
           
        }
        calprgsbar.setProgress(AppData.shared.progress, animated: true)
       
        calprgsbar.setProgress(Float(AppData.shared.calories) / (Float(AppData.shared.setmax)), animated: false)
        waterprogress.setProgress(Float(AppData.shared.water) / (Float(AppData.shared.watermax)), animated: false)
        proteinprogress.setProgress(Float(AppData.shared.protein) / (Float(AppData.shared.proteinmax)), animated: false)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        originalButtonYPosition = addcalbutton.frame.origin.y
        originalButton2YPosition = addbtnback.frame.origin.y
        
    }
    
    
    @IBOutlet weak var addbtnback: UIButton!
    @IBOutlet weak var prglessvaluelbl: UILabel!
    @IBOutlet weak var progresslbl: UILabel!
     
    var toggle: Int = 0
    
    @IBAction func chande(_ sender: UISegmentedControl) {
        toggle = sender.selectedSegmentIndex
    }
    
    @IBOutlet weak var testtitle: UILabel!
    @IBOutlet weak var crnt: UILabel!
    @IBAction func calorieadd(_ sender: UIButton) {
        if maxcalset == true {
            guard let text = valueTextField.text, let value = Int(text) else {
                showAlert(message: "Please enter a valid integer.")
                return
            }
            
            switch toggle {
            case 0: // Calories
                AppData.shared.calories += value
                if AppData.shared.calories > AppData.shared.setmax {
                    progress = 1.0
                } else {
                    progress = Float(AppData.shared.calories) / Float(AppData.shared.setmax)
                }
                calprgsbar.setProgress(progress, animated: true)
                
            case 1: // Water
                AppData.shared.water += value
                if AppData.shared.water > AppData.shared.watermax {
                    progressw = 1.0
                } else {
                    progressw = Float(AppData.shared.water) / Float(AppData.shared.watermax)
                }
                waterprogress.setProgress(progressw, animated: true)
                
            case 2: // Protein
                AppData.shared.protein += value
                if AppData.shared.protein > AppData.shared.proteinmax {
                    progressp = 1.0
                } else {
                    progressp = Float(AppData.shared.protein) / Float(AppData.shared.proteinmax)
                }
                proteinprogress.setProgress(progressp, animated: true)
                
            default:
                break
            }
            
            valueTextField.text = ""
            
        } else {
            showMessage()
        }
    }
    
    @IBOutlet weak var addherebtn: UIButton!
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let buttonYPosition = keyboardFrame.origin.y - addcalbutton.frame.height - 5
            addcalbutton.frame.origin.y = buttonYPosition
            let button2YPosition = keyboardFrame.origin.y - addbtnback.frame.height + 5
            addbtnback.frame.origin.y = button2YPosition
            kbdusd = true
        }
        if kbdusd == true {
            addherebtn.setTitle("", for: .normal)
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        addcalbutton.frame.origin.y = originalButtonYPosition
        addbtnback.frame.origin.y = originalButton2YPosition
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Invalid Input", message: "Input an integer value", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet weak var mxlabel: UILabel!
    @IBOutlet weak var addcalbutton: UIButton!
    
    var previousSliderValue: Float = 0.0
    
    func showMessage() {
        let alertController = UIAlertController(title: "Set max", message: "Set max in order to add calories", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var exit: UIButton!
    
    @IBOutlet weak var calprgsbar: UIProgressView!
}
