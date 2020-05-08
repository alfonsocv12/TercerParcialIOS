//
//  DatosViewController.swift
//  TercerParcialAlfonsoVillalobos
//
//  Created by apple on 5/7/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class DatosViewController: UIViewController {
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var direccionLabel: UILabel!
    @IBOutlet weak var lastNamesLabel: UILabel!
    @IBOutlet weak var latLongLabel: UILabel!
    @IBOutlet weak var blodTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AF.request("http://www.mocky.io/v2/5eb4f9fa0e00004e5a081e8e")
            .responseJSON {response in switch response.result {
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    self.setInfo(userData: response)
                case .failure(_):
                    self.Status.text = "No jalo"
            }
        }
    }
    
    func setInfo(userData: NSDictionary){
        let name: String = userData.object(forKey: "Name") as! String
        let LNFather = userData.object(forKey: "LNFather") as! String
        let LNMother = userData.object(forKey: "LNMother") as! String
        let lat = userData.object(forKey: "lat") as! String
        let long = userData.object(forKey: "long") as! String
        let urlImg = URL(string: userData.object(forKey: "img") as! String)
        let direccion = userData.object(forKey: "Home") as! String
        let blodType = userData.object(forKey: "blodType") as! String
        
        userImg.kf.setImage(with: urlImg)
        userImg.layer.cornerRadius = userImg.frame.height/2
        userImg.layer.borderWidth = 1
        userImg.layer.masksToBounds = false
        userImg.layer.borderColor = UIColor.black.cgColor
        userImg.clipsToBounds = true
        self.setBlodTypeStyle(blodType: blodType)
        self.latLongLabel.text = lat+", "+long
        self.direccionLabel.text = direccion
        self.lastNamesLabel.text = LNFather+" "+LNMother
        self.Status.text = name
    }
    
    func setBlodTypeStyle(blodType: String) {
        switch blodType.prefix(1) {
        case "A":
            if blodType.prefix(2) != "AB" {
                blodTypeLabel.textColor = UIColor.white
                blodTypeLabel.backgroundColor = UIColor.blue
            } else {
                blodTypeLabel.textColor = UIColor.white
                blodTypeLabel.backgroundColor = UIColor.black
            }
        case "B":
            blodTypeLabel.textColor = UIColor.white
            blodTypeLabel.backgroundColor = UIColor.green
        case "O":
            blodTypeLabel.textColor = UIColor.white
            blodTypeLabel.backgroundColor = UIColor.red
        default:
            blodTypeLabel.backgroundColor = UIColor.white
        }
        blodTypeLabel.layer.cornerRadius = 10
        blodTypeLabel.text = blodType
    }
}
