//
//  SearchViewController.swift
//  MyMeal
//
//  Created by greshan on 2023-04-05.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
//    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
//            "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
//            "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
//            "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
//            "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    let data: [String]! = nil
    
    var filteredData: [String]! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        filteredData = data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
            cell.textLabel?.text = filteredData[indexPath.row]
            return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (filteredData == nil) {
            return 0
        }
        return filteredData!.count
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
                
        tableView.reloadData()
    }
    
}
