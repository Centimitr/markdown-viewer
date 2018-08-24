//
//  View.swift
//  Markdown Viewer
//
//  Created by Xiao Shi on 19/1/18.
//  Copyright © 2018 devbycm. All rights reserved.
//

import WebKit

class MarkdownView: WKWebView {

    override open var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    var isScrolling: Bool {
        return (scrollView.isDragging) || (scrollView.isDecelerating)
    }
    
    func loadBundleHTML(_ name: String){
        let pageURL = Bundle.main.url(forResource: name, withExtension: "html")
        let request = URLRequest(url: pageURL!)
        load(request)
    }
}
