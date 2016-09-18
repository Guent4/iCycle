//
//  File.swift
//  iCycle
//
//  Created by David Gu on 9/16/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import AVFoundation
import UIKit

var session: AVCaptureSession!
var previewLayer: AVCaptureVideoPreviewLayer!

class BarcodeReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a session object.
        
        session = AVCaptureSession()
        
        // Set the captureDevice.
        
        let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Create input object.
        
        let videoInput: AVCaptureDeviceInput?
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        // Add input to the session.
        
        if (session.canAddInput(videoInput)) {
            session.addInput(videoInput)
        } else {
            scanningNotPossible()
        }
        
        // Create output object.
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        // Add output to the session.
        
        if (session.canAddOutput(metadataOutput)) {
            session.addOutput(metadataOutput)
            
            // Send captured data to the delegate object via a serial queue.
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            
            // Set barcode type for which to scan: EAN-13.
            
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code]
            
        } else {
            scanningNotPossible()
        }
        
        // Add previewLayer and have it show the video data.
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        // Begin the capture session.
        
        session.startRunning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (session?.running == false) {
            session.startRunning()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (session?.running == true) {
            session.stopRunning()
        }
    }
    
    func scanningNotPossible() {
        
        // Let the user know that scanning isn't possible with the current device.
        
        let alert = UIAlertController(title: "Can't Scan.", message: "Let's try a device equipped with a camera.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
        session = nil
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // Get the first object from the metadataObjects array.
        
        if let barcodeData = metadataObjects.first {
            
            // Turn it into machine readable code
            
            let barcodeReadable = barcodeData as? AVMetadataMachineReadableCodeObject;
            
            if let readableCode = barcodeReadable {
                
                // Send the barcode as a string to barcodeDetected()
                
                barcodeDetected(readableCode.stringValue);
            }
            
            // Vibrate the device to give the user some feedback.
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            // Avoid a very buzzy device.
            
            session.stopRunning()
        }
    }
    
    func barcodeDetected(code: String) {
        
        // Let the user know we've found something.
        
        let alert = UIAlertController(title: "Found a Barcode!", message: code, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Search", style: UIAlertActionStyle.Destructive, handler: { action in
            
            // Remove the spaces.
            
            let trimmedCode = code.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            // EAN or UPC?
            // Check for added "0" at beginning of code.
            
            let trimmedCodeString = "\(trimmedCode)"
            var trimmedCodeNoZero: String
            
            if trimmedCodeString.hasPrefix("0") && trimmedCodeString.characters.count > 1 {
                trimmedCodeNoZero = String(trimmedCodeString.characters.dropFirst())
                self.barcodeHandler(trimmedCodeNoZero)
            } else {
                self.barcodeHandler(trimmedCode)
            }
            
            self.navigationController?.popViewControllerAnimated(true)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        self.viewDidLoad()
    }
    
    private func barcodeHandler(code: String) {
        // determine if is recycler
        let recyclers = DataService.retrieveRecyclersByBarcode(code)
        let isRecycler = recyclers.count > 0
        // if recycler, then change state
        if isRecycler {
            print("is recycler")
            SCAN_STATE = [true, SCAN_STATE[1]]
            SCAN_RECENT = [code, SCAN_RECENT[1]]
        }
        // if not, then change state
        else {
            print("is item")
            SCAN_STATE = [SCAN_STATE[0], true]
            SCAN_RECENT = [SCAN_RECENT[0], code]
        }
        // check if both state is right, if so add item
        if SCAN_STATE[0] && SCAN_STATE[1] {
            let recyclerCode = SCAN_RECENT[0]
            let itemCode = SCAN_RECENT[1]
            DataService.recycleItem(UserID, itemCode: itemCode, recyclerCode: recyclerCode)
            SCAN_STATE[0] = false
            SCAN_STATE[1] = false
            SCAN_RECENT[0] = ""
            SCAN_RECENT[1] = ""
        }
    }
}
