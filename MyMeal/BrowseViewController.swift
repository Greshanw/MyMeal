//
//  BrowseViewController.swift
//  MyMeal
//
//  Created by greshan on 2023-04-03.
//

import UIKit

class BrowseViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...10 {
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
}
