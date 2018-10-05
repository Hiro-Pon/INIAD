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



class ViewController: UIViewController ,UIPickerViewDataSource,UIPickerViewDelegate{
    @IBOutlet var TimeLabel:UILabel!
    @IBOutlet var TimeSecondLabel:UILabel!
    @IBOutlet var RoomLabel:UILabel!
    @IBOutlet var illuminanceLabel:UILabel!
    @IBOutlet var humidityLabel:UILabel!
    @IBOutlet var airpressureLabel:UILabel!
    @IBOutlet var tempertureLabel:UILabel!
    @IBOutlet var roomPic: UIPickerView!
    @IBOutlet var GetButton:UIButton!
    
    
    let floor_nums = ["Floor3","Floor4"]
    let three_Room_nums = ["3101","3102","3105","3106","3109","3110","3114"
        ,"3201","3205","3209","3213","3217"]
    let four_Room_nums = ["4101","4102","4105","4106","4109","4110","4114"
        ,"4201","4205","4209","4213","4217"]
    
    var selected_floor:Int = 3
    var selected_room:String = "3101"
    var room_row:Int = 0
    let BASE_URL = "https://edu-iot.iniad.org/api/v1"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RoomLabel.text = "Room Number:" + selected_room
        GetButton.layer.cornerRadius = 10
        roomPic.delegate = self
        roomPic.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // API取得の開始処理
    func getroomData(room_num:String) {
        RoomLabel.text = "Room Number:" + selected_room
        let room_URL = "/sensors/" + room_num
        Alamofire.request(BASE_URL + room_URL)
            .authenticate(user: "s1F101702497", password: "")
            .responseJSON {response in
                if response.result.value != nil{
                    if let json:JSON = JSON(response.result.value!){
                        print("JSON: \(json)")  // serialized json response
                        
                        if json["description"] == "Service available only on INIAD LAN"{
                            let alert = UIAlertController(title: "Error", message: "INIAD-WiFiに接続してください", preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(OKAction)
                            self.present(alert, animated: true)
                        }else{
                            let formatter = DateFormatter()
                            formatter.dateFormat = "HH:mm"
                            formatter.locale = Locale(identifier: "ja_JP")
                            let secondformatter = DateFormatter()
                            secondformatter.dateFormat = "ss"
                            secondformatter.locale = Locale(identifier: "ja_JP")
                            print(secondformatter.string(from: Date()))
                            print(formatter.string(from: Date()))
                            self.TimeLabel.text = "Time:" + formatter.string(from: Date())
                            self.TimeSecondLabel.text = secondformatter.string(from: Date())
                            
                            let illuminance_value = json[0]["value"].description
                            let humidity_value = json[1]["value"].description
                            let airpressure_value = json[2]["value"].description
                            let temperature_value = json[3]["value"].description
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
        getroomData(room_num: selected_room)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        if component == 1{
            if selected_floor == 3 {
                return three_Room_nums.count
            }else{
                return four_Room_nums.count
            }
        }else{
            return floor_nums.count
        }
        
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if component == 1{
            if selected_floor == 3 {
                return three_Room_nums[row]
            }else{
                return four_Room_nums[row]
            }
        }else{
            return floor_nums[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if component == 1{
            if selected_floor == 3 {
                //                textField.text = three_Room_nums[row]
                selected_room = three_Room_nums[row]
                //RoomLabel.text = "Room Number:" + selected_room
                room_row = row
            }else {
                //                textField.text = four_Room_nums[row]
                selected_room = four_Room_nums[row]
                //RoomLabel.text = "Room Number:" + selected_room
                room_row = row
            }
        }else{
            selected_floor = row + 3
            roomPic.delegate = self
            roomPic.dataSource = self
            
            
            
            if selected_floor == 3 {
                //                textField.text = three_Room_nums[row]
                selected_room = three_Room_nums[room_row]
                //RoomLabel.text = "Room Number:" + selected_room
            }else {
                //                textField.text = four_Room_nums[row]
                selected_room = four_Room_nums[room_row]
                //RoomLabel.text = "Room Number:" + selected_room
            }
        }
        print(selected_room)
    }
}

