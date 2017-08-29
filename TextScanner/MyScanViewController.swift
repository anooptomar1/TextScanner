//
//  MyScanViewController.swift
//  PassportOCR
//
//  Created by Edwin Vermeer on 9/7/15.
//  Copyright (c) 2015 mirabeau. All rights reserved.
//

import Foundation

class MyScanViewController: UIViewController, RVTTextScannerViewDelegate {
    
    @IBOutlet weak var textScannerView: RVTTextScannerView!
    /// Delegate set by the calling controler so that we can pass on ProcessMRZ events.
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textScannerView.delegate = self
        self.textScannerView.showCropView = true
        self.textScannerView.cropView?.edgeColor = UIColor.lightGray
        self.textScannerView.cropView?.progressColor = UIColor.red
        self.textScannerView.startScan()
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
     override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
     override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func scannerDidRecognizeText(_ scanner: RVTTextScannerView, textResult: RVTTextResult, image: UIImage?) {
        
    }
    
    func scannerDidFindCommontextResult(_ scanner: RVTTextScannerView, textResult: RVTTextResult, image: UIImage?) {
        
        self.label.text = textResult.lines.first! + textResult.lines.last!
        self.imageView.image = image
        print(textResult.text, textResult.lines.first, textResult.whiteSpacedComponents)
        self.view.layoutIfNeeded()
        
//        self.textScannerView.stopScan()
//        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

