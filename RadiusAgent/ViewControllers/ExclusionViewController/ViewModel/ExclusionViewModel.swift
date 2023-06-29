//
//  ExclusionViewModel.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import Foundation

class ExclusionViewModel {
    
    var success: VoidCompletionHandler?
    var failure: StringCompletionHandler?
    
    var baseModel: CMBaseExclusion = CMBaseExclusion()
    var lastSelectedOption: CMExclusionOption = CMExclusionOption()
}

extension ExclusionViewModel {
    
    private func successCompletion() {
        guard let success else { return }
        success()
    }
    
    private func failureCompletion(msg: String) {
        guard let failure else { return }
        failure(msg)
    }
}

extension ExclusionViewModel {
        
    func callWebservicesForFetchingData() {
        let successCallback: SuccessResponse = { dict in
            self.parseResponse(dict: dict)
        }
        let failure: FailureResponse = { error in
            
        }
        APIClient.callWebserviceForFetchingDataFromServer(successCompletion: successCallback,
                                                          failureCompletion: failure)
    }
    
    private func parseResponse(dict: JSONDictionary) {
        baseModel = CMBaseExclusion(withDict: dict)
        successCompletion()
    }
}

extension ExclusionViewModel {
    var facilityList: [CMExclusionFacility] {
        baseModel.facilityList
    }
    var exclusionList: [[CMExclusionData]] {
        baseModel.exclusionList
    }
    var flatExclusionList: [CMExclusionData] {
        baseModel.flatExclusionList
    }
    var sectionCount: Int {
        facilityList.count
    }
    
    func noOfRows(section: Int) -> Int {
        facilityList[section].optionList.count
    }
    
    func dataForSection(section: Int) -> CMExclusionFacility {
        facilityList[section]
    }
    
    func titleForHeader(section: Int) -> String {
        dataForSection(section: section).name
    }
    
    func dataForRow(indexPath: IndexPath) -> CMExclusionOption {
        facilityList[indexPath.section].optionList[indexPath.row]
    }
    
    func dataListForSection(section: Int) -> [CMExclusionOption] {
        facilityList[section].optionList
    }
    
    func resetOptionSelection(section: Int) {
        facilityList[section].isSelected = false
        dataListForSection(section: section).forEach {
            $0.isSelected = false
        }
    }
    
    func resetAll() {
        facilityList.forEach {
            $0.isSelected = false
            $0.optionList.forEach { option in
                option.isSelected = false
            }
        }
    }
}

extension ExclusionViewModel {
    
    func checkForExclusion(indexPath: IndexPath) -> Bool {
        let currentFacility = dataForSection(section: indexPath.section)
        var isSelectable: Bool = true
        switch indexPath.section {
            case 0:
                if let option = currentFacility.optionList.first(where: { $0.isSelected == true }) {
                    resetAll()
                    option.isSelected = true
                    lastSelectedOption = option
                }
            default:
                if let option = currentFacility.optionList.first(where: { $0.isSelected == true }) {
                    if lastSelectedOption.exclusionId == option.id {
                        isSelectable = false
                    }
                }
        }
        return isSelectable
    }
}

