//
//  LockerViewController.swift
//  INIAD
//
//  Created by 中嶋裕也 on 2018/05/25.
//  Copyright © 2018年 中嶋裕也. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LockerViewController: UIViewController {
    @IBOutlet var GetButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        GetButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let BASE_URL = "https://edu-iot.iniad.org/api/v1"
    
    
    
    @IBAction func OpenLocker(){
//        openlocker()
        openlocker()
    }
    
    func openlocker(){
        let locker_URL = "/locker/open"
        Alamofire.request(BASE_URL + locker_URL ,method:.post)
            .authenticate(user: "s1F101702497", password: "Aa1392691087")
            .responseJSON {response in
                
                if let json:JSON = JSON(response.result.value!){
                    print("JSON: \(json)")  // serialized json response
                    
                    if json["description"] == "Service available only on INIAD LAN"{
                        let alert = UIAlertController(title: "Error", message: "INIAD-WiFiに接続してください", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(OKAction)
                        self.present(alert, animated: true)
                    }else{
                        let alert = UIAlertController(title: "成功", message: "ロッカーを開けました", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(OKAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
                
        }
    }
    func getlockerposition(){
        let locker_URL = "/locker"
        Alamofire.request(BASE_URL + locker_URL)
            .authenticate(user: "s1F101702497", password: "Aa1392691087")
            .responseJSON {response in
                print("Request: \(String(describing: response.request))")
                print("Response: \(String(describing: response.response))")
                print("Result: \(String(describing: response.result))")
                
                if let json:JSON = JSON(response.result.value!){
                    print("JSON: \(json)")  // serialized json response
                    
                    
                }
                
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
