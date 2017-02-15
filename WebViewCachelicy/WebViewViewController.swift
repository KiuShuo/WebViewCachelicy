//
//  WebViewViewController.swift
//  PAWebView
//
//  Created by shuo on 2017/2/14.
//  Copyright © 2017年 shuo. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var needClearCache: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if needClearCache {
            URLCache.shared.removeAllCachedResponses()
        }
        let ip = "192.168.2.2"
        let urlStr = "http://\(ip)/test.txt"
        if let url = URL(string: urlStr) {
            /**
                // cachePolicy设置不同值时界面的显实效果：
                
                cachePolicy: .useProtocolCachePolicy 这时候当test.txt文件发生改变的时候，加载出来的界面还是改变之前的，即使用的是缓存数据；
                cachePolicy: .reloadIgnoringLocalCacheData 不会使用缓存数据，断网后页面为空白界面；
                cachePolicy: .reloadIgnoringLocalAndRemoteCacheData 不会使用缓存数据，断网后页面为空白界面；
                cachePolicy: .returnCacheDataElseLoad 如果有缓存数据就直接使用缓存数据，否则在从服务器请求；
                cachePolicy: .returnCacheDataDontLoad 如果有缓存数据就直接使用缓存数据，否则页面为空白界面；
                cachePolicy: .reloadRevalidatingCacheData 每次请求时服务器数据发生改变后界面也跟着改变；
             */
            let urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60.0)
            webView.loadRequest(urlRequest)
        }
    }

}

extension WebViewViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("加载开始")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("加载完成")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("加载失败\(error.localizedDescription)")
    }
    
}
