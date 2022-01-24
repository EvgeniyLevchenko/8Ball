//
//  MainViewController.swift
//  8Ball
//
//  Created by QwertY on 24.01.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private weak var answerLabel: UILabel!
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension MainViewController {
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        networkManager.getDataFromJSON()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = networkManager.magicAnswer?.magic.answer
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = networkManager.magicAnswer?.magic.answer
    }

}
