//
//  ViewController.swift
//  PAWebView
//
//  Created by shuo on 2017/2/14.
//  Copyright © 2017年 shuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clearCacheBt: UIButton!
    var isClear: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isClear {
            clearCacheBt.setTitle("clearCache", for: .normal)
        } else {
            clearCacheBt.setTitle("no clearCache", for: .normal)
        }
    }
    
    @IBAction func clickClearCacheBt(_ sender: Any) {
        if isClear {
            isClear = false
            clearCacheBt.setTitle("no clearCache", for: .normal)
        } else {
            isClear = true
            clearCacheBt.setTitle("clearCache", for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebDetailViewController" {
            let webDetailViewController = segue.destination as! WebViewViewController
            webDetailViewController.needClearCache = isClear
        }
    }
    
    
}

