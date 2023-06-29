//
//  ExclusionViewController.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import UIKit

class ExclusionViewController: UIViewController {
    
    //MARK:- IBOUTLETS
    //================
    @IBOutlet weak var exclusionTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARKE:- Variables
    //================
    private let viewModel: ExclusionViewModel = ExclusionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerTableCell()
        setupCompletionHandler()
        animateActivityIndicator(true)
        viewModel.callWebservicesForFetchingData()
    }
    
    private func setupCompletionHandler() {
        viewModel.success = {
            self.reloadTable()
            self.animateActivityIndicator(false)
        }
        viewModel.failure = { msg in
            self.animateActivityIndicator(false)
        }
    }
    
    func animateActivityIndicator(_ isAnimate: Bool) {
        DispatchQueue.mainQueueAsync { [weak self] in
            guard let self else { return }
            isAnimate ? self.activityIndicator.startAnimating():self.activityIndicator.stopAnimating()
        }
    }
}

extension ExclusionViewController: TableDelegate {
    
    func registerTableCell() {
        [HomeTableCell.self,
         HomeHeaderTableCell.self].forEach {
            exclusionTable.registerCell(with: $0)
        }
    }
    
    func reloadTable() {
        DispatchQueue.mainQueueAsync { [weak self] in
            guard let self else { return }
            self.exclusionTable.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionCount
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.noOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let aCell = exclusionTable.dequeueCell(with: HomeHeaderTableCell.self)
        let title = viewModel.titleForHeader(section: section)
        aCell.configureCellUI(title: title)
        return aCell.contentView
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = exclusionTable.dequeueCell(with: HomeTableCell.self)
        let exclusionOption = viewModel.dataForRow(indexPath: indexPath)
        aCell.configureCellUI(exclusionOption: exclusionOption)
        return aCell.setSelectionStyleNone
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        viewModel.resetOptionSelection(section: indexPath.section)
        viewModel.dataForRow(indexPath: indexPath).isSelected = true
        let isSelectable = viewModel.checkForExclusion(indexPath: indexPath)
        if isSelectable == false {
            viewModel.resetOptionSelection(section: indexPath.section)
            showAlert(message: "Please choose different option")
        }
        reloadTable()
    }
    
    private func showAlert(title: String = "Alert",
                           message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            print("OK button tapped")
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
