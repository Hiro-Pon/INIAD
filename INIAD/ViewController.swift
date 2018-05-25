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
import SwiftyJSON



class ViewController: UIViewController {
    @IBOutlet var illuminanceLabel:UILabel!
    @IBOutlet var humidityLabel:UILabel!
    @IBOutlet var airpressureLabel:UILabel!
    @IBOutlet var tempertureLabel:UILabel!
    @IBOutlet var textField:UITextField!
    
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
    func getroomData(room_num:String) {
        let room_URL = "/sensors/" + room_num
        Alamofire.request(BASE_URL + room_URL)
            .authenticate(user: "s1F101702497", password: "Aa1392691087")
            .responseJSON {response in
                print("Result: \(String(describing: response.result))")

                if let json:JSON = JSON(response.result.value!){
                    print("JSON: \(json)")  // serialized json response
                    
                    let illuminance_value = json[0]["value"].description
                    let humidity_value = json[1]["value"].description
                    let airpressure_value = json[2]["value"].description
                    let temperature_value = json[3]["value"].description
                    print(type(of: illuminance_value))

                    print(illuminance_value,humidity_value,airpressure_value,temperature_value)
                    self.illuminanceLabel.text = illuminance_value
                    self.humidityLabel.text = humidity_value
                    self.airpressureLabel.text = airpressure_value
                    self.tempertureLabel.text = temperature_value
                    //let first = json[0]
                    //self.PrintLabel.text = String(first)
                    //print(type(of: json[0]))
                    
                }
                
        }
        
    }
    
    func hanteiroom(room_num: String) -> Bool {
        let room_URL = "/sensors/3102"
        var han:Bool = false
        Alamofire.request(BASE_URL + room_URL)
            .authenticate(user: "s1F101702497", password: "Aa1392691087")
            .responseJSON {response in
                let chr_result = response.result.description
                print(chr_result)
                if  chr_result == "SUCCESS" {
                    han = true
                }
                
                
        }
        return han
    }
    

    
    
    @IBAction func getData(){
//        var array:NSArray = []
//        if hanteiroom(room_num: "3102"){
//            array.adding(3)
//        }
//        print(hanteiroom(room_num: "3102"))
//        print(array)
//        for i in 3000..<4000 {
//            getroomData(room_num: String(i))
//
//        }
        let num = textField.text!
        getroomData(room_num: num)
    }
    
}

