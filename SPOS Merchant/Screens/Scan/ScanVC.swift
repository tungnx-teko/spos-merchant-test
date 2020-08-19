//
//  ScanVC.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import AVFoundation
import SwifterSwift

class ScanVC: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var rectOfInterestArea = UIView()
    var darkView = UIView()
    
    var scanRect:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    let metadataOutput = AVCaptureMetadataOutput()
    
    let frameLength: CGFloat = 30
    let frameWidth: CGFloat = 4
    
    let defaultTerminalCode = "PE1118CC50322"
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.borderWidth = 1
        button.borderColor = .white
        button.cornerRadius = 4.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue \(defaultTerminalCode)", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quét terminal code"
        
        openLogin()
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        let size = 300
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let xPos = (CGFloat(screenWidth) / CGFloat(2)) - (CGFloat(size) / CGFloat(2))
        let yPos = CGFloat(screenHeight) / CGFloat(2) - (CGFloat(size) / CGFloat(2)) - 52
        scanRect = CGRect(x: Int(xPos), y: Int(yPos), width: size, height: size)
        
        rectOfInterestArea.frame = scanRect
        
        view.addSubview(rectOfInterestArea)
        
//        print(rectOfInterestArea.frame.size.height, " ", rectOfInterestArea.frame.size.width )
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(previewLayer)
        
//        print(previewLayer.frame.size.height, " ", previewLayer.frame.size.width )
        
        view.addSubview(rectOfInterestArea)
        
        
        captureSession.startRunning()
        metadataOutput.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: scanRect)
        
        
        
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        continueButton.addTarget(self, action: #selector(onClickContinue), for: .touchUpInside)
    }
    
    func openLogin() {
        let loginVC = PhoneLoginVC(nibName: "PhoneLoginVC", bundle: nil)
        
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc func onClickContinue() {
        continueWith(terminalCode: defaultTerminalCode)
    }
    
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.rectOfInterestArea.layer.addSublayer(self.createFrame())
        
//        blurBackground()
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        continueWith(terminalCode: code)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
//    func createFrame() -> CAShapeLayer {
//        let height: CGFloat = self.rectOfInterestArea.frame.size.height
//        let width: CGFloat = self.rectOfInterestArea.frame.size.width
//        print(height, " " , width)
//        //let h = previewLayer.frame.size.height
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: frameWidth, y: frameLength))
//        path.addLine(to: CGPoint(x: frameWidth, y: frameWidth))
//        path.addLine(to: CGPoint(x: frameLength, y: frameWidth))
//        path.move(to: CGPoint(x: height - frameLength, y: frameWidth))
//        path.addLine(to: CGPoint(x: height - frameWidth, y: frameWidth))
//        path.addLine(to: CGPoint(x: height - frameWidth, y: frameLength))
//        path.move(to: CGPoint(x: frameWidth, y: width - frameLength))
//        path.addLine(to: CGPoint(x: frameWidth, y: width - frameWidth))
//        path.addLine(to: CGPoint(x: frameLength, y: width - frameWidth))
//        path.move(to: CGPoint(x: width - frameLength, y: height - frameWidth))
//        path.addLine(to: CGPoint(x: width - frameWidth, y: height - frameWidth))
//        path.addLine(to: CGPoint(x: width - frameWidth, y: height - frameLength))
//        let shape = CAShapeLayer()
//        shape.path = path.cgPath
//        shape.strokeColor = UIColor.red.cgColor
//        shape.lineWidth = frameWidth
//        shape.fillColor = UIColor.clear.cgColor
//        return shape
//    }
//
//    func blurBackground() {
//        let path = CGMutablePath()
//        path.addRect(view.bounds)
//        path.addRect(rectOfInterestArea.frame)
//
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = path
//        maskLayer.fillColor = UIColor.black.withAlphaComponent(0.6).cgColor
//        maskLayer.fillRule = .evenOdd
//
//        view.layer.addSublayer(maskLayer)
//    }
//
}

extension ScanVC {
    
    func continueWith(terminalCode: String) {
        ClientManager.shared.terminalCode = terminalCode
        
        let createOrderVC = CreateOrderVC.init(nibName: "CreateOrderVC", bundle: nil)
        self.navigationController?.pushViewController(createOrderVC)
    }
    
}
