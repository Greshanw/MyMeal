//
//  BrowseViewController.swift
//  MyMeal
//
//  Created by greshan on 2023-04-03.
//

import UIKit

class BrowseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var categoriesCollectionView: UICollectionView!
    
    let url = "https://www.themealdb.com/api/json/v1/1/categories.php"
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category", for: indexPath) as? CategoryCell {
            categoryCell.configure(with: categories[indexPath.row])
            
            cell = categoryCell
        }
        return cell
    }

    
    func loadData() {
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            // have data
            var result: Categories?
            do {
                result = try JSONDecoder().decode(Categories.self, from: data)
            } catch {
                print(String(describing: error))
            }
            
            guard let json = result else {
                return
            }

            self.assignValues(json.categories)
            
        }).resume()
    }
    
    func assignValues(_ categories: [Category]){
        self.categories = categories
        DispatchQueue.main.async {
            self.categoriesCollectionView.reloadData()
        }
    }
}
