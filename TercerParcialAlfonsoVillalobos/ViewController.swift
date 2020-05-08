//
//  ViewController.swift
//  TercerParcialAlfonsoVillalobos
//
//  Created by apple on 5/7/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var Status: UILabel!
    
    var authError: NSError?
    let context =  LAContext()
    var log = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login.layer.cornerRadius = 10
    }
        
    @IBAction func start(_ sender: Any) {
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Dejeme lo checo en el sistema joven", reply: { (success: Bool, error: Error?)-> Void in
                if  success {
                    self.log = true
                    DispatchQueue.main.async {
                        let story = UIStoryboard(name: "Main", bundle: nil)
                        let datosViewController = story.instantiateViewController(identifier: "DatosViewController") as? DatosViewController
                        datosViewController?.title = "Entro"
                        self.present(datosViewController!, animated:true, completion:nil)
                    }
                } else {
                    self.log = false
                }
            })
        } else {
            Status.text = "Error"
        }
    }
    
}

