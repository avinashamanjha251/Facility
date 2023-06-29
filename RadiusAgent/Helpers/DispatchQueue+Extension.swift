//
//  DispatchQueue+Extension.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import Foundation
import UIKit

extension DispatchQueue {
        
    ///Returns the main queue asynchronuously
    class func mainQueueAsync(_ closure:@escaping ()->()){
        self.main.async(execute: {
            closure()
        })
    }
}
