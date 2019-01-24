//
//  LoginViewController.swift
//  Simproofn
//
//  Created by Hamzhya on 23/01/19.
//  Copyright © 2019 Hamzhya. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding



class LoginViewController: UIViewController {

    @IBOutlet weak var formView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        KeyboardAvoiding.avoidingView = self.formView
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var passwordTextField: KTextField!
    @IBOutlet weak var usernameTextField: KTextField!
    
    public func showAlert(withTitle title: String, message: String){
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
//        let usernameGenerator = "ajihairi";
//        let passwordGenerator = "123";
        
        let username = usernameTextField.text;
        let password = passwordTextField.text;
        var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn");
        
        let datas = UserDefaults.standard;
//        datas.set(usernameGenerator, forKey: "userIdentifier")
//        datas.set(passwordGenerator, forKey: "userPassword")
        let idChecker = UserDefaults.standard.string(forKey: "userIdentifier")
        let passChecker = UserDefaults.standard.string(forKey: "userPassword")
    
        
        if (username == idChecker){
            if (password == passChecker) {
                self.performSegue(withIdentifier: "homeView", sender: self)
//                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "homeView") as UIViewController
                isLoggedIn = true
                datas.set(isLoggedIn, forKey: "isLoggedIn")
//                self.present(initViewController, animated: true, completion: nil)
                
            } else {
                showAlert(withTitle: "Login Failed", message: "username or password incorrect")
            }
            
        } else {
            showAlert(withTitle: "Login Failed", message: "username or password incorrect")
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
