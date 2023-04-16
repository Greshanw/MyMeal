//
//  CategoryCell.swift
//  MyMeal
//
//  Created by greshan on 2023-04-16.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var image: UIImageView!
    
    func configure(with category: Category) {
        label.text = category.strCategory
        
        let imageUrlString = category.strCategoryThumb
        
        guard let url = URL(string: imageUrlString) else {
                    return
                }
                
        DispatchQueue.main.async {
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self.image.image = loadedImage
                }
            }
        }
    }
}
