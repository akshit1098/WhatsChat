//
//  LoginRegisterViewController.swift
//  ChaChat
//
//  Created by Akshit Saxena on 2/11/24.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginRegisterViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func loginClicked(_ sender: Any) {
        
        if(!checkInput()){
            return
        }
        
        let email = emailTextField.text
        let password = passwordTextField.text
        Auth.auth().signIn(withEmail: email!, password: password!) { user, error in
            if let error = error {
                Utilities().showAlert(title: "Error", message: error.localizedDescription, vc: self)
                return
            }
            print("Signed In")
        }


    }
    
    func checkInput()->Bool{
        if((emailTextField.text!.count) < 5){
            emailTextField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            return false
        }else{
            emailTextField.backgroundColor = UIColor.white
        }
        
        if((passwordTextField.text!.count) < 5){
            passwordTextField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            return false
        }else{
            passwordTextField.backgroundColor = UIColor.white
        }
        return true
        
    }
    
    
    @IBAction func registerClicked(_ sender: Any) {
        if(!checkInput()){
            return
        }
        
        let alert = UIAlertController(title: "Register", message: "Please confirm the password", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "password"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action)->Void in
            let passConfirm = alert.textFields![0] as UITextField
            if (passConfirm.text!.isEqual(self.passwordTextField.text!)){
                
                //registration begins
                let email = self.emailTextField.text
                let password = self.passwordTextField.text
                
                Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
                    if let error = error{
                        Utilities().showAlert(title: "Error", message: error.localizedDescription, vc: self)
                        return
                    }
                    self.dismiss(animated: true, completion: nil)
                }
                
            }else{
                Utilities().showAlert(title: "Error", message: "Passwords are not the same!!", vc: self)
            }
        }))
        self.present(alert, animated: true, completion: nil)
            
    }
    
    
    
    @IBAction func forgotClicked(_ sender: Any) {
        if(!emailTextField.text!.isEmpty){
            let email = self.emailTextField.text
            
            Auth.auth().sendPasswordReset(withEmail: email!, completion: { (error) in
                if let error = error{
                    Utilities().showAlert(title: "Error", message: error.localizedDescription, vc: self)
                    return
                }
                Utilities().showAlert(title: "Success", message: "Please Check your email!!", vc: self)
            })
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
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
