//
//  CMBaseExclusion.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import Foundation

class CMBaseExclusion: NSObject {
    
    let facilityList: [CMExclusionFacility]
    let exclusionList: [[CMExclusionData]]
    let flatExclusionList: [CMExclusionData]

    convenience override init() {
        self.init(withDict: JSONDictionary())
    }
    
    init(withDict dict: JSONDictionary) {
        if let aList = dict["facilities"] as? JSONDictionaryArray {
            facilityList = aList.map { CMExclusionFacility(withDict: $0) }
        } else {
            facilityList = []
        }
        var uniqueID: Int = 1
        if let aList = dict["exclusions"] as? [JSONDictionaryArray] {
            var exclList: [[CMExclusionData]] = []
            var exList: [CMExclusionData] = []
            for aDataList in aList {
                var excList: [CMExclusionData] = []
                for item in aDataList {
                    excList.append(CMExclusionData(withDict: item, uniqueID: 0))
                    let model = CMExclusionData(withDict: item,
                                                uniqueID: uniqueID)
                    exList.append(model)
                }
                uniqueID += 1
                exclList.append(excList)
            }
            exclusionList = exclList
            flatExclusionList = exList
        } else {
            exclusionList = []
            flatExclusionList = []
        }
        
        for item in facilityList {
            for option in item.optionList {
                if let data = flatExclusionList.first(where: { $0.facilityID == item.facilityID
                    && $0.optionsID == option.id}) {
                    if let exData = flatExclusionList.first(where: { $0.uniqueID == data.uniqueID
                        && $0.facilityID != item.facilityID
                        && $0.optionsID != option.id
                    }) {
                        option.exclusionId = exData.optionsID
                    }
                }
            }
        }
    }
}

// MARK: - CMExclusionData
class CMExclusionData: NSObject {
    let facilityID: String
    let optionsID: String
    let uniqueID: Int
    
    convenience override init() {
        self.init(withDict: JSONDictionary(),
                  uniqueID: 0)
    }
    
    init(withDict dict: JSONDictionary,
         uniqueID: Int) {
        self.uniqueID = uniqueID
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

// MARK: - CMExclusionFacility
class CMExclusionFacility: NSObject {
    let facilityID: String
    let name: String
    let optionList: [CMExclusionOption]
    var isSelected: Bool = false

    convenience override init() {
        self.init(withDict: JSONDictionary())
    }
    
    init(withDict dict: JSONDictionary) {
        var facilityID: String = ""
        if let data = dict["facility_id"] as? String {
            facilityID = data
        }
        self.facilityID = facilityID
        if let data = dict["name"] as? String {
            name = data
        } else {
            name = ""
        }
        if let aList = dict["options"] as? JSONDictionaryArray {
            optionList = aList.map { CMExclusionOption(withDict: $0,
                                                       facilityID: facilityID) }
        } else {
            optionList = []
        }
    }
}

// MARK: - CMExclusionOption
class CMExclusionOption: NSObject {
    let name: String
    let icon: String
    let id: String
    let facilityID: String
    
    var exclusionId: String = ""
    var isSelected: Bool = false

    convenience override init() {
        self.init(withDict: JSONDictionary(),
                  facilityID: "")
    }
    
    init(withDict dict: JSONDictionary,
         facilityID: String) {
        self.facilityID = facilityID
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
