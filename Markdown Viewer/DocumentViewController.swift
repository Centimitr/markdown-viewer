//
//  DocumentViewController.swift
//  Markdown Viewer
//
//  Created by Xiao Shi on 14/1/18.
//  Copyright © 2018 devbycm. All rights reserved.
//

import UIKit
import WebKit

class DocumentViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var documentNameLabel: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var statusBarBg: UIView!

    var document: UIDocument?
    var mdView: MarkdownView?

//    var statusBarShouldBeHidden = false
//
//    override var prefersStatusBarHidden: Bool {
//        return statusBarShouldBeHidden
//    }

    override func viewDidLoad() {
        UIApplication.shared.isStatusBarHidden = true

        mdView = MarkdownView(frame: (view?.bounds)!)
        mdView?.loadBundleHTML("Main")
        view.insertSubview(mdView!, at: 0)

        let swipeBack = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(dismissDocumentViewController))
        swipeBack.edges = .left
        view.addGestureRecognizer(swipeBack)

        let toggleTitleBar = UITapGestureRecognizer(target: self, action: #selector(handleToggleTitleBar))
        toggleTitleBar.numberOfTapsRequired = 1
        toggleTitleBar.delegate = self
        view.addGestureRecognizer(toggleTitleBar)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    @objc func handleToggleTitleBar() {
        if !(mdView?.isScrolling)! {
            let to = !navBar.isHidden
            navBar.isHidden = to
            statusBarBg.isHidden = to
            UIApplication.shared.isStatusBarHidden = to
//            self.statusBarShouldBeHidden = to
//            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
//                self.statusBarShouldBeHidden = true
//                self.setNeedsStatusBarAppearanceUpdate()
                self.documentNameLabel.title = self.document?.fileURL.lastPathComponent
                let doc = self.document as! Document
                self.mdView?.evaluateJavaScript("window._cm_cache = `\(doc.content)`", completionHandler: nil)
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }

    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
//            self.statusBarShouldBeHidden = false-
//            self.setNeedsStatusBarAppearanceUpdate()
            UIApplication.shared.isStatusBarHidden = false
            self.document?.close(completionHandler: nil)
        }
    }

    @IBAction func unwind(for segue: UIStoryboardSegue) {
    }
}
