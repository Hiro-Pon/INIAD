//
//  ClassesViewController.swift
//  INIAD
//
//  Created by 中嶋裕也 on 2018/05/28.
//  Copyright © 2018年 中嶋裕也. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ClassesViewController: UIViewController {
    
    var webV:UIWebView!
    /*
    let BASE_URL:URL = URL(string: "https://g-sys.toyo.ac.jp/univision/action/in/f08/Usin080111")!
    func loadurl(){
        let reqest = NSURLRequest(url: BASE_URL)
        webV.loadRequest(reqest as URLRequest)
        
        Alamofire.request(BASE_URL).authenticate(user: "s1F101702497", password: "Aa1392691087")
        
    }
    */
    
    func getHtmlData(url: String) -> String {
        var myhtml:String = "ERROR"
        let request = NSMutableURLRequest(url: URL(string: url)!)
        let userAgent = UIWebView().stringByEvaluatingJavaScript(from: "navigator.userAgent")
        
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        do {
             myhtml = try String(contentsOf: request.url!, encoding: .utf8)
        }catch{
        }
        
        return myhtml
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //print(getHtmlData(url: "https://ja.stackoverflow.com/questions/33522/swift3-モバイルサイトのhtmlデータ-取得方法について"))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
