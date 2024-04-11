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
    @IBOutlet var image: UIImageView!
    

    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailDescription.isEditable = false
        getRandomCocktail(UIButton())
    }
    
    
    
    @IBAction func getRandomCocktail(_ sender: UIButton) {
        networkManager.fetchCocktail(){[unowned self] cocktail in
            DispatchQueue.main.async {
                self.name.text = cocktail?.strDrink
                self.cocktailDescription.text = cocktail?.strInstructions

            }
            guard let urlImage = cocktail?.strDrinkThumb else { return}
            networkManager.fetchImage(urlString: urlImage) {[unowned self] image in
                DispatchQueue.main.async {
                    self.image.image = image

                }
            }
            
        }
    }
    

}

