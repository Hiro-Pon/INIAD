//
//  ViewController.swift
//  INIAD
//
//  Created by 中嶋裕也 on 2018/05/21.
//  Copyright © 2018年 中嶋裕也. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class ViewController: UIViewController {
    @IBOutlet var illuminanceLabel:UILabel!
    @IBOutlet var humidityLabel:UILabel!
    @IBOutlet var airpressureLabel:UILabel!
    @IBOutlet var tempertureLabel:UILabel!
    
    
    let BASE_URL = "https://edu-iot.iniad.org/api/v1"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // API取得の開始処理
    func getroomData() {
        let room_URL = "/sensors/3102"
        Alamofire.request(BASE_URL + room_URL)
            .authenticate(user: "s1F101702497", password: "Aa1392691087")
            .responseJSON {response in
                print("Request: \(String(describing: response.request))")
                print("Response: \(String(describing: response.response))")
                print("Result: \(String(describing: response.result))")
                
                if let json:NSArray = response.result.value as? NSArray{
                    print("JSON: \(json)")  // serialized json response
                    
                    let illuminance = json[0] as? NSDictionary
                    let humidity = json[1] as? NSDictionary
                    let airpressure = json[2] as? NSDictionary
                    let temperature = json[3] as? NSDictionary
                    
                    let illuminance_value = illuminance!["value"] as? String
                    let humidity_value = humidity!["value"] as? String
                    let airpressure_value = airpressure!["value"] as? String
                    let temperature_value = temperature!["room_num"]
                    
                    self.illuminanceLabel.text = illuminance_value
                    self.humidityLabel.text = humidity_value
                    self.airpressureLabel.text = airpressure_value
                    self.tempertureLabel.text = temperature_value as! String
                    //let first = json[0]
                    //self.PrintLabel.text = String(first)
                    //print(type(of: json[0]))
                    
                }
                
        }
        
    }
    func openlocker(){
        let locker_URL = "/locker/open"
        Alamofire.request(BASE_URL + locker_URL)
            .authenticate(user: "s1F101702497", password: "Aa1392691087")
            .responseJSON {response in
                
        }
    }
    
    
    @IBAction func getData(){
        getroomData()
    }
    
}

