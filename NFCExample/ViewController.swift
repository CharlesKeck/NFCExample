//
//  ViewController.swift
//  NFCExample
//
//  Created by Charles on 13/1/20.
//  Copyright © 2020 Charles. All rights reserved.
//

import UIKit
import CoreNFC


class ViewController: UIViewController, NFCNDEFReaderSessionDelegate { //, NFCTagReaderSessionDelegate {
    
    var session: NFCNDEFReaderSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        session = NFCTagReaderSession(pollingOption: [.iso14443], delegate: self, queue: nil)
        session?.alertMessage = "Hold your iPhone near an NFC."
        session?.begin()
 
         */
        beginScanning()
    }
    
    @IBAction func ScanButton(_ sender: Any) {
     beginScanning()
    }
    
    func beginScanning() {
        /* session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
            */
            guard NFCNDEFReaderSession.readingAvailable else {
                let alertController = UIAlertController(
                    title: "Scanning Not Supported",
                    message: "This device doesn't support tag scanning.",
                    preferredStyle: .alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
           
            }
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
        session?.alertMessage = "Hold your iPhone near the item to learn more about it."
        session?.begin()
    }
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages
        {
            for record in message.records
            {
                if let string = String(data: record.payload, encoding: .ascii)
                {
                    print(string)
                }
            }
        }
    }

    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("Active")
    }
}

