//
//  MealCell.swift
//  MyMeal
//
//  Created by greshan on 2023-04-16.
//

import UIKit

class MealCell: UICollectionViewCell {
    
    @IBOutlet var uiView: UIView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var label: UILabel!
    
    func configure(with meal: Meal) {
        
        uiView.layer.cornerRadius = 10
        label.text = meal.strMeal
        
        let imageUrlString = meal.strMealThumb
        
        
        if let url = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
              // Error handling...
              guard let imageData = data else { return }

              DispatchQueue.main.async {
                  self.image.image = UIImage(data: imageData)
              }
            }.resume()
          }

    }
}
