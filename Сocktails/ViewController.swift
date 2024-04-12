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
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var backButton: UIButton!
    

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
        index = 0
        var postfix = ""
        postfix = sender.tag == 0 ? "random.php" : "search.php?s=\(searchTF.text ?? "margarita")"
        //random.php
        networkManager.fetchCocktail(urlPostfix: postfix) {[unowned self] drink in
            self.drinks = drink
            updateUI(cocktail: self.drinks?.drinks.first)
        }
    }
    
    @IBAction func nextAndBack(_ sender: UIButton) {
        if sender.tag == 1 {
            index += 1
            if index < drinks?.drinks.count ?? 0 {
                updateUI(cocktail: drinks?.drinks[index])
            } else {
                index = 0
            }
        }
        if sender.tag == 0 {
            index -= 1
            if index < drinks?.drinks.count ?? 0 && index >= 0{
                updateUI(cocktail: drinks?.drinks[index])
            } else {
                index = 0
            }
        }
    }
    
    
    func updateUI(cocktail: Cocktail?) {
        DispatchQueue.main.async { [unowned self] in
            nextButton.isEnabled = !(index == (drinks?.drinks.count ?? 0) - 1)
            backButton.isEnabled = !((index == (drinks?.drinks.count ?? 0) - 1) || index == 0)
            name.text = cocktail?.strDrink
            cocktailDescription.text = cocktail?.strInstructions
            ingredients.text = cocktail?.getIngredients()
        }
        guard let urlImage = cocktail?.strDrinkThumb else { return}
        networkManager.fetchImage(urlString: urlImage) {[unowned self] image in
            DispatchQueue.main.async {
                self.image.image = image
            }
        }
    }
}

