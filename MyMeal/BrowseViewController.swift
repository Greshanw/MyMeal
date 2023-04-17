//
//  BrowseViewController.swift
//  MyMeal
//
//  Created by greshan on 2023-04-03.
//

import UIKit

class BrowseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var categoriesCollectionView: UICollectionView!
    @IBOutlet var mealsCollectionView: UICollectionView!
    @IBOutlet var categoryLabel: UILabel!
    
    let categoryUrl = "https://www.themealdb.com/api/json/v1/1/categories.php"
    let mealsUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    var categories: [Category] = []
    var meals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        loadMeals(category: "Beef")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == self.categoriesCollectionView ? categories.count : meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if(collectionView == self.categoriesCollectionView){
            if let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category", for: indexPath) as? CategoryCell {
                categoryCell.configure(with: categories[indexPath.row])
                
                cell = categoryCell
            }
        }
        else {
            if let mealCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Meal", for: indexPath) as? MealCell {
                mealCell.configure(with: meals[indexPath.row])
                
                cell = mealCell
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == self.categoriesCollectionView){
            categoryLabel.text = categories[indexPath.row].strCategory
            loadMeals(category: categories[indexPath.row].strCategory)
        }
//        else {
//
//        }
    }

    
    func loadCategories() {
        
        URLSession.shared.dataTask(with: URL(string: categoryUrl)!, completionHandler: {data, response, error in
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

            self.assignCategories(json.categories)
            
        }).resume()
    }
    
    func assignCategories(_ categories: [Category]){
        self.categories = categories
        DispatchQueue.main.async {
            self.categoriesCollectionView.reloadData()
        }
    }
    
    func loadMeals(category: String) {
        let url = mealsUrl + category
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            // have data
            var result: Meals?
            do {
                result = try JSONDecoder().decode(Meals.self, from: data)
            } catch {
                print(String(describing: error))
            }
            
            guard let json = result else {
                return
            }
            
            self.assignMeals(json.meals)
            
        }).resume()
    }
    
    func assignMeals(_ meals: [Meal]){
        
        self.meals = meals
        DispatchQueue.main.async {
            self.mealsCollectionView.reloadData()
        }
    }
}
