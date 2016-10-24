//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Luis Perez on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

enum SectionIdentifier : String {
    case OfferingDeal = ""
    case Distance = "Distance"
    case SortBy = "Sort by"
    case Category = "Category"
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    var categories: [[String: String]]!
    
    // Table contains no data at initialization.
    let sectionToIdentifier: [SectionIdentifier] = [.OfferingDeal, .Distance, .SortBy, .Category]
    var tableData: [SectionIdentifier: [Int: Option]] = [
        .OfferingDeal: [Int: Option](),
        .Distance: [Int: Option](),
        .SortBy: [Int: Option](),
        .Category: [Int: Option]()
    ]
    
    var currentFilters: Filters! {
        didSet {
            tableData[.OfferingDeal] = currentFilters.offeringDeal
            tableData[.Distance] = currentFilters.distance
            tableData[.SortBy] = currentFilters.sortby
            tableData[.Category] = currentFilters.categories
            
            tableView.reloadData()
        }
    }
    
    
    weak var delegate: FiltersViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        currentFilters = currentFilters ?? Filters()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func preferencesFromTableData() -> Filters {
        let newFilters = Filters()
        newFilters.categories = tableData[.Category] ?? newFilters.categories
        return newFilters
    }
    
    @IBAction func searchButtonClicked(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
        
        var filters = [String: AnyObject]()
        
        // Categories
        let switchStates = tableData[.Category]!
        let selectedStates = switchStates.filter({(row: Int, data: Option) -> Bool in data.isOn })
        let selectedCategories = selectedStates.map({(row: Int, data: Option) -> String in data.code as! String })
        if (selectedCategories.count > 0){
            filters["categories"] = selectedCategories as AnyObject
        }
        
        // Sortby
        let sortMode = tableData[.SortBy]!.filter({(row: Int, data: Option) -> Bool in data.isOn })
        if sortMode.count > 0 {
            filters["sortBy"] = sortMode[0].value.sortMode as AnyObject
        }
        // Deals
        let isDeal = tableData[.OfferingDeal]!.filter({(row: Int, data: Option) -> Bool in data.isOn })
        if isDeal.count > 0 {
            filters["isDeal"] = isDeal[0].value.isOn as AnyObject
        }
        
        // Distance
        let distance = tableData[.Distance]!.filter({(row: Int, data: Option) -> Bool in data.isOn })
        if distance.count > 0 {
            filters["distance"] = distance[0].value.distanceMode as AnyObject
        }
    
        delegate?.filtersViewController?(filtersViewController: self, didUpdateFilters: filters)
    }

    @IBAction func cancelButtonClicked(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        let data: Option = (tableData[sectionToIdentifier[indexPath.section]]?[indexPath.row])!
        
        cell.delegate = self
        cell.switchLabel.text = data.name
        cell.onSwitch.isOn = data.isOn
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionData = tableData[sectionToIdentifier[section]] {
            return sectionData.count
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionToIdentifier[section].rawValue
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        
        // Depending on the section, we have slightly different functionality. Some sections can be selected multiple times, others not.
        let identifier = sectionToIdentifier[indexPath.section]
        switch (identifier) {
        case .Distance,
             .SortBy:
            Filters.turnAllOff(options: tableData[identifier])
        default:
            break
        }
        tableData[identifier]?[indexPath.row]?.isOn = value
        
        tableView.reloadData()
    }
}
