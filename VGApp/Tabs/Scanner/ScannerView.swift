//
//  ScannerView.swift
//  VGApp
//
//  Created by Kiara on 11.02.22.
//

import UIKit
import AVFoundation

class ScannerView: UIViewController {
    var avCaptureSession: AVCaptureSession!
    var avPreviewLayer: AVCaptureVideoPreviewLayer!
    let scanAlert = UIAlertController(title: "alert_title_scannerAddNew".localized, message: "", preferredStyle: .alert)
    var lastScanned: String = ""
    var cameraHadError = false
    lazy var errorLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 80))
        label.backgroundColor = UIColor.red
        label.numberOfLines = 3
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        view.addSubview(errorLabel)
        self.navigationItem.title = "scannerView_title".localized
        
        scanAlert.addTextField(configurationHandler: {(textfield) in
            textfield.placeholder = "scannerView_item_placeholder_name".localized
        })
        
        scanAlert.addAction(UIAlertAction(title: "alert_action_scanner_cancel".localized, style: .cancel, handler: {_ in
            self.scanAlert.dismiss(animated: true, completion: nil)
            self.avCaptureSession.startRunning()
        }))
        scanAlert.addAction(UIAlertAction(title: "alert_action_add".localized, style: .default, handler: {_ in
            Util.createItem(name: self.scanAlert.textFields![0].text!, code: self.lastScanned)
            
            DispatchQueue.global(qos: .background).async {
                self.avCaptureSession.startRunning()
            }
        }))
        
        super.viewDidLoad()
        avCaptureSession = AVCaptureSession()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
                self.failed()
                return
            }
            let avVideoInput: AVCaptureDeviceInput
            
            do {
                avVideoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                self.failed()
                return
            }
            
            if self.avCaptureSession.canAddInput(avVideoInput) {
                self.avCaptureSession.addInput(avVideoInput)
            } else {
                self.failed()
                return
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if self.avCaptureSession.canAddOutput(metadataOutput) {
                self.avCaptureSession.addOutput(metadataOutput)
                
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
            } else {
                self.failed()
                return
            }
            
         //   cameraHadError = false
            self.avPreviewLayer = AVCaptureVideoPreviewLayer(session: self.avCaptureSession)
            self.avPreviewLayer.frame = self.view.layer.bounds
            self.avPreviewLayer.videoGravity = .resizeAspectFill
            self.view.layer.addSublayer(self.avPreviewLayer)
            
            DispatchQueue.global(qos: .background).async {
                self.avCaptureSession.startRunning()
            }
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "alert_title_scanner_noCamera".localized, message: "alert_message_scanner_noCamera".localized, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "alert_action_ok".localized, style: .default))
       // present(ac, animated: true)
        cameraHadError = true
        avCaptureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if avCaptureSession?.isRunning == false {
            DispatchQueue.global(qos: .background).async {
                self.avCaptureSession.startRunning()
            }
        }
        if avCaptureSession == nil || ((avCaptureSession?.isRunning) == nil) {
            cameraHadError = true
        }
        
        setLabel()
    }

    func setLabel() {
        if !cameraHadError {
            errorLabel.isHidden = true
            return
        }
        
        let frame = view.frame
        errorLabel.frame = CGRect(x: 0, y: 0, width: frame.width - 50, height: 80)
        errorLabel.center = CGPoint(x: frame.width/2, y: frame.height/2)
        errorLabel.text = "scannerView_nocamera".localized
        errorLabel.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if avCaptureSession?.isRunning == true {
            avCaptureSession.stopRunning()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
        
}

// evertyhign scanner stuff from http://www.wepstech.com/bar-qr-code-ios-with-swift-5/
    extension ScannerView: AVCaptureMetadataOutputObjectsDelegate {
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            avCaptureSession.stopRunning()
            
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                found(code: stringValue)
            }
            
          //  dismiss(animated: true)
        }
        
        func found(code: String) {
            self.lastScanned = processsString(code)
            avCaptureSession.stopRunning()
            scanAlert.textFields![0].text = checkCode(self.lastScanned)
            present(scanAlert, animated: true, completion: nil)
        }
        
        func processsString(_ str: String) -> String {
            if str.count < 4 { return "0000"}
            let newStr = str.dropLast()
            return String(newStr.suffix(4))
        }
        
        func checkCode(_ code: String) -> String? {
            let all = CoreData.getHistory().filter {$0.number == code}
            if all.isEmpty {return nil}
            return all.first?.name
        }
    }

enum scannerText {
    case None
    case NoCamera
    case NoPermission
}
