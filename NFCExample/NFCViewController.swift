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
    
    
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        beginScanning()
    }
    
    var session:NFCTagReaderSession?
    
    func beginScanning() {
        session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self, queue: nil)
        session?.alertMessage = "Hold your iPhone near the ISO7816 tag to begin transaction."
        session?.begin()
    }
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("Active")
        DispatchQueue.main.async {
            self.message.text = "Active\n"
        }
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            self.message.text = error.localizedDescription
        }
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        print("\(tags)")
        if case let NFCTag.iso7816(tag) = tags.first! {
          print(tag.identifier as NSData)
        }
        
        DispatchQueue.main.async {
            self.message.text! = "\(tags)\n"
            
        }
        session.restartPolling()
    }
    
    
    

    

}
