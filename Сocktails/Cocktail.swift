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
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    
    func getIngredients () -> String {
        let text1 = strIngredient1
        let text2 = strIngredient2
        let text3 = strIngredient3
        let text4 = strIngredient4
        let text5 = strIngredient5
        return "\(text1 ?? "")\n\(text2 ?? "")\n\(text3 ?? "")\n\(text4 ?? "")\n\(text5 ?? "")"
        
    }
}

struct Drink: Decodable {
    let drinks: [Cocktail]
}


