//
//  NSError+Extension.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import Foundation

extension NSError {
    
    convenience init(localizedDescription: String) {
        self.init(domain: "APIClientError",
                  code: 0,
                  userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
    
    convenience init(code: Int,
                     localizedDescription: String) {
        self.init(domain: "APIClientError",
                  code: code,
                  userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}
