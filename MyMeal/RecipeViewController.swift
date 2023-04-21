//
//  RecipeViewController.swift
//  MyMeal
//
//  Created by greshan on 2023-04-19.
//

import UIKit

class RecipeViewController: UIViewController, UIScrollViewDelegate {
    
    var mealId: String = ""
    let recipeUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    
    var recipe : Recipe?
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var recipeName: UILabel!
    @IBOutlet var areaLabel: UILabel!
    @IBOutlet var instructionText: UITextView!
    @IBOutlet var ingredientsStackView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(mealId)
        URLSession.shared.dataTask(with: URL(string: "\(recipeUrl)\(mealId)")!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            // have data
            var result: Recipies?
            do {
                result = try JSONDecoder().decode(Recipies.self, from: data)
            } catch {
                print(String(describing: error))
            }
            
            guard let json = result else{
                return
            }

            DispatchQueue.main.async { [self] in
                self.recipe = json.meals[0]
    
                let imageUrlString = self.recipe?.strMealThumb
                if let url = URL(string: imageUrlString!) {
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                      guard let imageData = data else { return }

                      DispatchQueue.main.async {
                          self.image.image = UIImage(data: imageData)
                      }
                    }.resume()
                  }
                
                self.recipeName.text = self.recipe?.strMeal
                self.areaLabel.text = self.recipe?.strArea
                self.instructionText.text = self.recipe?.strInstructions
            }
            
            
        }).resume()
    }

}
