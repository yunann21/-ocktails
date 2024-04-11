//
//  NetworkManager.swift
//  Сocktails
//
//  Created by Anna Ablogina on 10.04.2024.
//

import Foundation
import UIKit

final class NetworkManager {
    func fetchCocktail(completion: @escaping (Cocktail?) -> Void){
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/random.php")!
        URLSession.shared.dataTask(with: url) {  data, _, error in
            
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let drink = try JSONDecoder().decode(Drink.self, from: data)
                completion(drink.drinks.first)
            } catch {
                print(error.localizedDescription)
            }
            
            
        }.resume()
    }
    
    
    func fetchImage(urlString: String, completion: @escaping (UIImage?) -> Void){
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) {  data, _, error in
            
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
         
            let image = UIImage(data: data)
            completion(image)

        }.resume()
    }
}
