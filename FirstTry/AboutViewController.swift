//
//  AboutViewController.swift
//  FirstTry
//
//  Created by 王凯霖 on 2019/11/19.
//  Copyright © 2019 王凯霖. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加网页视图
        if let res_link = Bundle.main.url(forResource: "BullsEye", withExtension: "html"){
            let res_request = URLRequest(url: res_link)
            webView.load(res_request)
        }
        
//        if let res_link = URL.init(string: "https://www.apple.com/cn"){
//            let res_request = URLRequest(url:res_link)
//            webView.load(res_request)
//        }

        
    }
    @IBAction func backToMain(){
        dismiss(animated: true, completion: nil)
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
