//
//  FiltersViewController.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import UIKit

protocol FiltersViewControllerDelegate: class {
    func applyFilters(filters: [FilterType: [String]])
    func clearFilters()
}

class FiltersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = BookFilterViewModel()
    
    weak var delegate: FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupModel()
    }
    
    private func setupModel() {
        self.viewModel.reloadHandler = {
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clearAction(_ sender: Any) {
        self.viewModel.clearFilters()
        self.delegate?.clearFilters()
    }
    
    @IBAction func applyAction(_ sender: Any) {
        self.delegate?.applyFilters(filters: self.viewModel.filters)
        self.navigationController?.popViewController(animated: true)
    }
}

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "FilterTableViewCell",
                                      bundle: nil),
                                forCellReuseIdentifier: "FilterTableViewCell")
        self.tableView.register(UINib(nibName: "FilterHeaderView",
                                      bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "FilterHeaderView")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sectionCount
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return tableView.bounds.height/4
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height/4
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let sectionModel = self.viewModel.sectionModel(
            at: section
        ) as? HeaderModel else { return 0 }
        return sectionModel.isSelected ? self.viewModel.itemCount(at: section) : 0
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "FilterHeaderView"
        ) as? FilterHeaderView else { return UIView() }
        headerView.item = self.viewModel.sectionModel(at: section)
        headerView.tag = section
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "FilterTableViewCell"
        ) as! FilterTableViewCell
        cell.item = self.viewModel.item(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        self.viewModel.updateFilter(at: indexPath)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension FiltersViewController: FilterHeaderViewDelegate {
    
    func didSelect(headerView: FilterHeaderView) {
        let indexSet = IndexSet(integer: headerView.tag)
        self.tableView.reloadSections(indexSet, with: .automatic)
    }
}
