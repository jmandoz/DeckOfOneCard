//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Jason Mandozzi on 6/24/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation
import UIKit

class CardController {
    
    //singleton
    
    //Source of Truth
    
    //Static: Class method - function that can be called directly on a method
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    static func drawCard(completion: @escaping (Card?) -> Void) {
        // Step one: unwrap the optional base URL
        guard let url = baseURL else {completion(nil); return}
        
        // Step two: Construct your final URL
//        url.appendPathComponent("newCard")
        
        // Step three: Create a URL request to get data from
//         let request = URLRequest(url: url)
        
        // Step Four: Get the data from the URL Request
        do {
            let data = try Data(contentsOf: url)
            let jDecoder = JSONDecoder()
            let topLevelJSON = try jDecoder.decode(TopLevelJSON.self, from: data)
            let card = topLevelJSON.cards[0]
            completion(card)
            
        } catch {
            print("Error getting data from URL")
            completion(nil)
            return
        }
    }
    
    static func getImageFor(card: Card, completion: (UIImage?) -> Void) {
        // Step one: unwrap the optianl URL
        guard let url = URL(string: card.image) else {completion(nil); return}
        // Step two: Construct your final URL
        //        url.appendPathComponent("newCard")
        
        // Step three: Create a URL request to get data from
        //         let request = URLRequest(url: url)
        
        //Step four: Get the data from the URL Request
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            completion(image)
        } catch {
            print("Error fetching image for card: \(card.code)")
            completion(nil)
            return
        }
    }
}
