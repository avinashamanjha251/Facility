//
//  Helpers.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import Foundation

typealias VoidCompletionHandler = (() -> Void)
typealias StringCompletionHandler = ((String) -> Void)
typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]
typealias FailureResponse = (NSError) -> (Void)
typealias SuccessResponse = (_ json : JSONDictionary) -> ()


let isPrintDebugEnable = true
/// Print Debug
func printDebug<T>(_ obj : T) {
    #if DEBUG
    if isPrintDebugEnable == true { print(obj) }
    #endif
}

