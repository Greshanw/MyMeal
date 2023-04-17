//
//  CategoryCell.swift
//  MyMeal
//
//  Created by greshan on 2023-04-16.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet var uiView: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var image: UIImageView!
    
    func configure(with category: Category) {
        
        uiView.layer.cornerRadius = 20
        label.text = category.strCategory
        
        let imageUrlString = category.strCategoryThumb
        
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
