//
//  category.swift
//  MyMeal
//
//  Created by greshan on 2023-04-09.
//

import Foundation

struct Categories: Decodable {
    let categories: [Category]
}

struct Category: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
