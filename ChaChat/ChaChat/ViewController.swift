//
//  ViewController.swift
//  ChaChat
//
//  Created by Akshit Saxena on 2/11/24.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var messages: [DataSnapshot]? = [DataSnapshot]()
    
    var ref: DatabaseReference!
    private var _refHandle: DatabaseHandle!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(Auth.auth().currentUser == nil){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "firebaseLoginViewController")
            self.navigationController?.present(vc!, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.textField.delegate = self
        
        self.ref = Database.database().reference()
        ConfigureDatabase()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginRegisterViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
//        //logout
//        let firebaseAuth = Auth.auth()
//        do{
//            try firebaseAuth.signOut()
//        }catch let signoutError as NSError{
//            print("error signing out!!")
//            
//        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: self.view.window)
        
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func sendMessage(data: [String: String]){
        let packet = data
        self.ref.child("messages").childByAutoId().setValue(packet)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    deinit{
        self.ref.child("messages").removeObserver(withHandle: _refHandle)
    }
    
    func ConfigureDatabase(){
        _refHandle = self.ref.child("messages").observe(.childAdded, with: { (snapshot)->Void in
            self.messages!.append(snapshot)
            self.tableView.insertRows(at: [IndexPath(row: self.messages!.count-1, section: 0)], with: .automatic)
        })
    }
    
    @objc func keyboardWillShow(_ sender: NSNotification){
        let userInfo: [AnyHashable: Any] = sender.userInfo!
        let keyboardSize = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let offset: CGSize = ((userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size)!
        
        if keyboardSize!.height == offset.height{
            if self.view.frame.origin.y == 0{
                UIView.animate(withDuration: 0.15) {
                    self.view.frame.origin.y -= keyboardSize!.height
                }
            }
        }else{
            UIView.animate(withDuration: 0.15) {
                self.view.frame.origin.y += keyboardSize!.height - offset.height
            }
        }
                
    }
    
    @objc func keyboardWillHide(_ sender: NSNotification){
        let userInfo: [AnyHashable: Any] = (sender as NSNotification).userInfo!
        
        let keyboardSize = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        self.view.frame.origin.y += keyboardSize!.height
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Manually resign the first responder status
        if let text = textField.text, !text.isEmpty {
            let data = [Constants.MessageFields.text: text]
            sendMessage(data: data)
            textField.text = "" // Clear the text field after sending message
        }
        return true
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        
        let messageSnap: DataSnapshot! = self.messages![indexPath.row]
        
        let message = messageSnap.value as! Dictionary<String, String>
        
        if let text = message[Constants.MessageFields.text] as String?{
            cell.textLabel?.text = text
        }
        return cell
    }
   

}

