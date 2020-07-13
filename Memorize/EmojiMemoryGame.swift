 //
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by user177069 on 6/28/20.
//  Copyright © 2020 CS193p. All rights reserved.
//

import SwiftUI
 
 class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻","🎃","🕷","🙀","😇"]
        let randomPairs = Int.random(in: 1...5)
        
        return MemoryGame<String>(numberOfPairsOfCards: randomPairs, cardContentFactory: { (pairIndex: Int) -> String in
            return emojis[pairIndex]
        })
    }

    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }

    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    
}

 
  
 
