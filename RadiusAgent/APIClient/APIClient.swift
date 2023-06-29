//
//  APIClient.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import Foundation

class APIClient {
    
    static func callWebserviceForFetchingDataFromServer(successCompletion: @escaping SuccessResponse,
                                                        failureCompletion: @escaping FailureResponse) {
        guard let url = URL(string: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error {
                printDebug("Error: \(error)")
                failureCompletionHandler(error: error,
                                         failureCompletion: failureCompletion)
            } else {
                if let data {
                    do {
                        // convert data to json
                        if let json = try JSONSerialization.jsonObject(with: data,
                                                                       options: []) as? JSONDictionary {
                            // try to read out a dictionary
                            print(json)
                            successCompletion(json)
                        } else {
                            let err = NSError(localizedDescription: "Parsing error")
                            failureCompletionHandler(error: err,
                                                     failureCompletion: failureCompletion)
                        }
                    } catch let serializationError {
                        printDebug("Serialization Error: \(serializationError)")
                        failureCompletionHandler(error: serializationError,
                                                 failureCompletion: failureCompletion)
                    }
                } else {
                    printDebug("Unknown error")
                    let err = NSError(localizedDescription: "Unknown error")
                    failureCompletionHandler(error: err,
                                             failureCompletion: failureCompletion)
                }
            }
        }
        task.resume()
    }
    
    private static func failureCompletionHandler(error: Error,
                                                 failureCompletion: @escaping FailureResponse) {
        let err = NSError(localizedDescription: error.localizedDescription)
        failureCompletion(err)
    }
}
