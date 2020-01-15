//
//  NFCViewController.swift
//  NFCExample
//
//  Created by Charles on 14/1/20.
//  Copyright © 2020 Charles. All rights reserved.
//

import UIKit
import CoreNFC

class NFCViewController: UIViewController, NFCTagReaderSessionDelegate  {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        beginScanning()
    }
    
    var session:NFCTagReaderSession?
    
    func beginScanning() {
        session = NFCTagReaderSession(pollingOption: [.iso14443, .iso15693], delegate: self)
        session?.alertMessage = "Hold your iPhone near the ISO7816 tag to begin transaction."
        session?.begin()
    }
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("Active")
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        print("Detected")
    }
    
    
    

    

}
