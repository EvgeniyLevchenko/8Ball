//
//  MainViewController.swift
//  8Ball
//
//  Created by QwertY on 24.01.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private weak var answerLabel: UILabel!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var triangleImageView: UIImageView!
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateViews()
    }
    
    private func animateViews() {
        transformViews()
        
        UIView.animate(
            withDuration: 1,
            delay: 0.5,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: .curveEaseInOut,
            animations: {
                if let navigationBar = self.navigationController?.navigationBar {
                    navigationBar.transform = .identity
                }
                self.circleImageView.transform = .identity
                self.triangleImageView.transform = .identity
                self.answerLabel.transform = .identity
            },
            completion: nil
        )
    }
    
    private func transformViews() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.transform = CGAffineTransform(translationX: 0, y: -2 * navigationBar.frame.size.height)
        }
        circleImageView.transform = CGAffineTransform(translationX: 0, y: view.frame.size.height)
        triangleImageView.transform = CGAffineTransform(translationX: 0, y: view.frame.size.height)
        answerLabel.transform = CGAffineTransform(translationX: 0, y: view.frame.size.height)
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
