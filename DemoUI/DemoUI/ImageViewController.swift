//
//  ImageViewController.swift
//  DemoUI
//
//  Created by Chí Thành on 7/8/24.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var catImageView: UIImageView!
    
    @IBOutlet weak var dogImageView: UIImageView!
    
    @IBOutlet weak var horseImageView: UIImageView!
    
    @IBOutlet weak var dragonImageView: UIImageView!
    
    let animalImages: [String] = ["cat", "dog", "horse", "dragon"]
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        dogImageView.contentMode = .scaleAspectFit
    }
    

    @IBAction func onRandomImage(_ sender: Any) {
        
        let randomAnimalName = animalImages.randomElement()
        
        catImageView.image = UIImage(systemName: "circle.square")
        dogImageView.image = UIImage(named: randomAnimalName ?? "dog")
    }
    
}
