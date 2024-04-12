//
//  ViewController.swift
//  Сocktails
//
//  Created by Anna Ablogina on 10.04.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var name: UILabel!
    @IBOutlet var cocktailDescription: UITextView!
    @IBOutlet var ingredients: UITextView!
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var searchTF: UITextField!

    let networkManager = NetworkManager()
    
    var drinks: Drink? = nil
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailDescription.isEditable = false
        ingredients.isEditable = false
        cocktailDescription.layer.borderColor = UIColor.gray.cgColor
        cocktailDescription.layer.cornerRadius = 10
        cocktailDescription.layer.borderWidth = 1
        ingredients.layer.borderColor = UIColor.gray.cgColor
        ingredients.layer.cornerRadius = 10
        ingredients.layer.borderWidth = 1

        getRandomCocktail(UIButton())
    }
    
    @IBAction func getRandomCocktail(_ sender: UIButton) {
        var postfix = ""
        postfix = sender.tag == 0 ? "random.php" : "search.php?s=\(searchTF.text ?? "margarita")"
        //random.php
        networkManager.fetchCocktail(urlPostfix: postfix) {[unowned self] drink in
            self.drinks = drink
            index = 0
            updateUI(cocktail: self.drinks?.drinks.first)
        }
        
        if sender.tag == 2 {
            index += 1
            updateUI(cocktail: drinks?.drinks[index])
        }
    }
    
    func updateUI(cocktail: Cocktail?) {
        DispatchQueue.main.async {
            self.name.text = cocktail?.strDrink
            self.cocktailDescription.text = cocktail?.strInstructions
            self.ingredients.text = cocktail?.getIngredients()
        }
        guard let urlImage = cocktail?.strDrinkThumb else { return}
        networkManager.fetchImage(urlString: urlImage) {[unowned self] image in
            DispatchQueue.main.async {
                self.image.image = image
            }
        }
    }
}

