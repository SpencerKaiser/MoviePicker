//
//  ViewController.swift
//  MoviePicker
//
//  Created by Spencer Kaiser on 7/5/20.
//  Copyright © 2020 Spencer Kaiser. All rights reserved.
//

import UIKit

//struct Odds: Codable {
//    let name: String
//    let percentChance: String
//}
//
//struct RollResponse: Codable {
//    let winner: String
//    let newOdds: [Odds]
//}

class ViewController: UIViewController {
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    let moviePickerBaseUrl = "https://sk-movie-picker.herokuapp.com/api"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        winnerLabel.text = "Time to pick a movie!\n🎥🍿"
        descriptionLabel.text = ""
        
        if let url = URL(string: "\(moviePickerBaseUrl)/getOdds") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            URLSession.shared.dataTask(with: urlRequest) {data, res, err in
                if let data = data {
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let odds = responseJSON as? [[String: Any]] {
                        DispatchQueue.main.async {
                            guard let user1 = odds[0]["user"], let user1Chance = odds[0]["percentChance"], let user2 = odds[1]["user"], let user2Chance = odds[1]["percentChance"] else {
                                return
                            }
                            
                            self.descriptionLabel.text = "Odds for the next pick:\n\(user1) - \(user1Chance)%\n\(user2) - \(user2Chance)%"
                        }
                    }
                }
            }.resume()
        }
    }

    @IBAction func pickWinnerButtonTapped(_ sender: Any) {
        // Hit `/roll` api endpoint
        if let url = URL(string: "\(moviePickerBaseUrl)/roll") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            URLSession.shared.dataTask(with: urlRequest) {data, res, err in
                if let data = data {
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let json = responseJSON as? [String: Any], let winner = json["winner"] as? String, let odds = json["newOdds"] as? [[String: Any]] {
                        DispatchQueue.main.async {
                            self.winnerLabel.text = "Winner winner, chicken dinner! \(winner) picks the movie! 🎉"
                            
                            guard let user1 = odds[0]["user"], let user1Chance = odds[0]["percentChance"], let user2 = odds[1]["user"], let user2Chance = odds[1]["percentChance"] else {
                                return
                            }
                            
                            self.descriptionLabel.text = "Odds for the next pick:\n\(user1) - \(user1Chance)%\n\(user2) - \(user2Chance)%"
                        }
                    }
                }
            }.resume()
        }
    }
    
}

