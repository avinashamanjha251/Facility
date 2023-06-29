//
//  HomeViewModel.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import Foundation

class HomeViewModel {
    
    var success: VoidCompletionHandler?
    var failure: StringCompletionHandler?
    
    var baseModel: CMBaseHome = CMBaseHome()
}

extension HomeViewModel {
    
    private func successCompletion() {
        guard let success else { return }
        success()
    }
    
    private func failureCompletion(msg: String) {
        guard let failure else { return }
        failure(msg)
    }
}

extension HomeViewModel {
    
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
        baseModel = CMBaseHome(withDict: dict)
        successCompletion()
    }
}

extension HomeViewModel {
    var facilityList: [CMFacility] {
        baseModel.facilityList
    }
    var sectionCount: Int {
        facilityList.count
    }
    
    func noOfRows(section: Int) -> Int {
        facilityList[section].optionList.count
    }
    
    func titleForHeader(section: Int) -> String {
        facilityList[section].name
    }
    
    func dataForRow(indexPath: IndexPath) -> CMOption {
        facilityList[indexPath.section].optionList[indexPath.row]
    }
    
    func dataListForSection(section: Int) -> [CMOption] {
        facilityList[section].optionList
    }
    
    func resetOptionSelection(section: Int) {
        dataListForSection(section: section).forEach {
            $0.isSelected = false
        }
    }
}
