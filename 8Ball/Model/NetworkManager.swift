//
//  NetworkManager.swift
//  8Ball
//
//  Created by QwertY on 24.01.2022.
//

import Foundation

class NetworkManager {
    
    var magicAnswer: MagicAnswer?
    
    func getDataFromJSON() {
        let urlString = "https://8ball.delegator.com/magic/JSON/qwerty"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            } else {
                getRandomUserAnswer()
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let decodedMagicAnswer = try? decoder.decode(MagicAnswer.self, from: json) {
            magicAnswer = decodedMagicAnswer
        } else {
            getRandomUserAnswer()
        }
    }
    
    func getRandomUserAnswer() {
        if let randomAnswer = UserAnswers.answers.randomElement() {
            let randomMagicAnswer = MagicAnswer(magic: Magic(answer: randomAnswer))
            magicAnswer = randomMagicAnswer
        } else {
            let errorAnswer = "I have no answers for you"
            let errorMagicAnswer = MagicAnswer(magic: Magic(answer: errorAnswer))
            magicAnswer = errorMagicAnswer
        }
    }
}
