//
//  CMBaseHome.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import Foundation

class CMBaseHome: NSObject {
    
    let facilityList: [CMFacility]
    let exclusionList: [[CMExclusion]]

    convenience override init() {
        self.init(withDict: JSONDictionary())
    }
    
    init(withDict dict: JSONDictionary) {
        if let aList = dict["facilities"] as? JSONDictionaryArray {
            facilityList = aList.map { CMFacility(withDict: $0) }
        } else {
            facilityList = []
        }
        if let aList = dict["exclusions"] as? [JSONDictionaryArray] {
            var exclList: [[CMExclusion]] = []
            for aDataList in aList {
                var excList: [CMExclusion] = []
                for item in aDataList {
                    excList.append(CMExclusion(withDict: item))
                }
                exclList.append(excList)
            }
            exclusionList = exclList
        } else {
            exclusionList = []
        }
    }
}

// MARK: - CMExclusion
class CMExclusion: NSObject {
    let facilityID: String
    let optionsID: String

    convenience override init() {
        self.init(withDict: JSONDictionary())
    }
    
    init(withDict dict: JSONDictionary) {
        if let data = dict["facility_id"] as? String {
            facilityID = data
        } else {
            facilityID = ""
        }
        if let data = dict["options_id"] as? String {
            optionsID = data
        } else {
            optionsID = ""
        }
    }
}

// MARK: - CMFacility
class CMFacility: NSObject {
    let facilityID: String
    let name: String
    let optionList: [CMOption]

    convenience override init() {
        self.init(withDict: JSONDictionary())
    }
    
    init(withDict dict: JSONDictionary) {
        if let data = dict["facility_id"] as? String {
            facilityID = data
        } else {
            facilityID = ""
        }
        if let data = dict["name"] as? String {
            name = data
        } else {
            name = ""
        }
        if let aList = dict["options"] as? JSONDictionaryArray {
            optionList = aList.map { CMOption(withDict: $0) }
        } else {
            optionList = []
        }
    }
}

// MARK: - CMOption
class CMOption: NSObject {
    let name: String
    let icon: String
    let id: String
    
    var isSelected: Bool = false

    convenience override init() {
        self.init(withDict: JSONDictionary())
    }
    
    init(withDict dict: JSONDictionary) {
        if let data = dict["name"] as? String {
            name = data
        } else {
            name = ""
        }
        if let data = dict["icon"] as? String {
            icon = data
        } else {
            icon = ""
        }
        if let data = dict["id"] as? String{
            id = data
        } else {
            id = ""
        }
    }
}
