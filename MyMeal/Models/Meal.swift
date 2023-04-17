//
//  Meal.swift
//  MyMeal
//
//  Created by greshan on 2023-04-16.
//

import Foundation

struct Meals: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
