//
//  TextDetectorViewController.swift
//  VisionSample
//
//  Created by Mohssen Fathi on 6/27/17.
//  Copyright © 2017 mohssenfathi. All rights reserved.
//

import UIKit
import Vision
import AVFoundation

class TextDetectorViewController: BaseVisionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        camera.position = .back
    }
    
    func convert(cmage:CIImage) -> UIImage {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    override func didOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer) {
        super.didOutput(output, didOutput: sampleBuffer)
        
        TextDetector.detectText(in: sampleBuffer) { results in
            DispatchQueue.main.async {
                if results.count > 0 {
                    debugPrint("results.count: \(results.count)")
                }

                if let observe: VNDetectedObjectObservation = results.first {
                    let boundingBox: CGRect = observe.boundingBox
                    
                    let imageBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
                    let ciimage: CIImage = CIImage(cvPixelBuffer: imageBuffer)
                    let image: UIImage = self.convert(cmage: ciimage)
                    let cgImage: CGImage = image.cgImage!
                    
                    let imageRect = self.camera.previewLayer.frame
                    let w = boundingBox.size.width * imageRect.width
                    let h = boundingBox.size.height * imageRect.height
                    let x = boundingBox.origin.x * imageRect.width + imageRect.origin.x
                    let y = imageRect.maxY - (boundingBox.origin.y * imageRect.height) - h
                    let relativeBox: CGRect = CGRect(x: x, y: y, width: w, height: h)

                    let imageRef: CGImage = cgImage.cropping(to: relativeBox)!;
                    debugPrint(imageRef)
                }
                
                let paths = results.map { observation -> UIBezierPath in
                    
                    let imageRect = self.camera.previewLayer.frame
                    let w = observation.boundingBox.size.width * imageRect.width
                    let h = observation.boundingBox.size.height * imageRect.height
                    let x = observation.boundingBox.origin.x * imageRect.width + imageRect.origin.x
                    let y = imageRect.maxY - (observation.boundingBox.origin.y * imageRect.height) - h
                    
                    return UIBezierPath(rect: CGRect(x: x, y: y, width: w, height: h))
                }
                
                self.updateAnnotations(with: paths)
            }
        }
    }
    
}
