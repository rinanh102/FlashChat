//
//  RegisterViewController.swift
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController, UITextFieldDelegate {

    
    //Pre-linked IBOutlets
   
   
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var emailTextfield: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: current ViewController is treated as a Delegate of TextField
        passwordTextfield.delegate = self
        emailTextfield.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        
        //TODO: Set up a new user on our Firbase database
        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil{
                print(error!)
            }else{
                //success
                print("Registration successful")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }
    //TODO: when user tap the Return key -> dismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    
    //TODO: when user tap anywhere not textField -> dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
