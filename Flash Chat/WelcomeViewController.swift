//
//  WelcomeViewController.swift
//
//  This is the welcome view controller - the first thing the user sees
//

import UIKit



class WelcomeViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loginBtn.frame
        loginBtn.layer.cornerRadius = loginBtn.bounds.size.height / 2
        signupBtn.layer.cornerRadius = signupBtn.bounds.size.height / 2

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
