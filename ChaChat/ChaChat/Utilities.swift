//
//  Utilities.swift
//  ChaChat
//
//  Created by Akshit Saxena on 2/11/24.
//

import Foundation
import UIKit

class Utilities{
    
    func showAlert(title: String, message: String, vc: UIViewController){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
}
