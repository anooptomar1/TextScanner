//
//  ViewController.swift
//  TextScanner
//
//  Created by Edwin Vermeer on 9/8/15.
//  Copyright (c) 2015 Mirabeau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    @IBAction func startScan(_ sender: AnyObject) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let scanVC: MyScanViewController = storyboard.instantiateViewController(withIdentifier: "MyScanViewController") as! MyScanViewController
        let navigationController = UINavigationController(rootViewController: scanVC)
        self.present(navigationController, animated: true, completion: nil)
    }
}

