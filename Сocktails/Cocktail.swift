//
//  Cocktail.swift
//  Сocktails
//
//  Created by Anna Ablogina on 10.04.2024.
//

import Foundation

struct Cocktail: Decodable {
    let strDrink: String
    let strInstructions: String
    let strDrinkThumb: String
}

struct Drink: Decodable {
    let drinks: [Cocktail]
}
