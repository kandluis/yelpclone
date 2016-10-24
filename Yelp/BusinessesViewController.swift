//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate, FiltersViewControllerDelegate {
    
    var businesses: [Business]! {
        didSet {
            self.filteredBusiness = businesses
        }
    }
    var filteredBusiness: [Business]!
    var searchBar: UISearchBar!
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 120
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        Business.searchWithTerm(term: "Restaurants", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableview.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
    }
    
    // FilterViewControllerDelegate
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        let categories = filters["categories"] as? [String]
        let sort = filters["sortBy"] as? YelpSortMode
        let deals = filters["isDeal"] as? Bool
        print("Deals \(deals)")
        let radius = filters["distance"] as? RadiusMode
        Business.searchWithTerm(term: "Restaurants", sort: sort, categories: categories, deals: deals, radius: radius, completion: {[unowned self](businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.tableview.reloadData()
        })
    }
    
    
    // UITableViewDataSource and UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = filteredBusiness {
            return businesses.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "BusinessCell") as! BusinessCell
        cell.business = filteredBusiness[indexPath.row]
        return cell
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredBusiness = searchText.isEmpty ? businesses : businesses.filter({(business: Business) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return business.name?.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableview.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        filteredBusiness = businesses
        tableview.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
