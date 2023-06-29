//
//  HomeViewController.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK:- IBOUTLETS
    //================
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARKE:- Variables
    //================
    private let viewModel: HomeViewModel = HomeViewModel()

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

extension HomeViewController: TableDelegate {
    
    func registerTableCell() {
        [HomeTableCell.self,
         HomeHeaderTableCell.self].forEach {
            homeTable.registerCell(with: $0)
        }
    }
    
    func reloadTable() {
        DispatchQueue.mainQueueAsync { [weak self] in
            guard let self else { return }
            self.homeTable.reloadData()
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
        let aCell = homeTable.dequeueCell(with: HomeHeaderTableCell.self)
        let title = viewModel.titleForHeader(section: section)
        aCell.configureCellUI(title: title)
        return aCell.contentView
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = homeTable.dequeueCell(with: HomeTableCell.self)
        let option = viewModel.dataForRow(indexPath: indexPath)
        aCell.configureCellUI(option: option)
        return aCell.setSelectionStyleNone
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        viewModel.resetOptionSelection(section: indexPath.section)
        viewModel.dataForRow(indexPath: indexPath).isSelected = true
        reloadTable()
    }
}
