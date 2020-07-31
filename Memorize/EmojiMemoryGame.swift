 //
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by user177069 on 6/28/20.
//  Copyright © 2020 CS193p. All rights reserved.
//

import SwiftUI
 
 class Theme {
 
    static var themes: [Dictionary<String, Any>] = [
        ["names":"Halloween", "emojis": ["👻","🎃","🕷","☠️","👽"], "numberOfCards": 5],
        ["names":"Faces", "emojis": ["😀","😍","☹️","😎","😇"], "numberOfCards": 5],
        ["names":"Sports", "emojis": ["⚽️","🏈","🥎","🎱","🏓"], "numberOfCards": 5],
        ["names":"Animals", "emojis": ["🦄","🐧","🐼","🙀","🦊"], "numberOfCards": 5],
        ["names":"Hearts", "emojis": ["❤️","🧡","💛","💚","💙","💜","🖤","🤍","🤎"]],
        ["names":"Food", "emojis": ["🍏","🥑","🥦","🥐","🌭"], "numberOfCards": 5]
        ]
     
    static var randomInteger = Int.random(in: 0..<themes.count)
    static var themeName: String = themes[randomInteger]["names"] as! String
    static var emojis: Array<String> = themes[randomInteger]["emojis"]  as! [String]
    static var randomPairs = themes[randomInteger]["numberOfCards"] as? Int ?? emojis.count
    
 }
 
 class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame(themeName: Theme.themeName, emojis: Theme.emojis, randomPairs: Theme.randomPairs)
        
    static func createMemoryGame(themeName: String, emojis: [String], randomPairs: Int) -> MemoryGame<String> {

        return MemoryGame<String>(themeName: themeName, numberOfPairsOfCards: randomPairs, cardContentFactory: { (pairIndex: Int) -> String in
            return emojis[pairIndex]
        })
    }
    	
    //CHECKIT
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return self.model.cards
    }

    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
        
    func startNewGame() {
        
        Theme.randomInteger = Int.random(in: 0..<Theme.themes.count)
        Theme.themeName = Theme.themes[Theme.randomInteger]["names"] as! String
        Theme.emojis = Theme.themes[Theme.randomInteger]["emojis"]  as! [String]
        Theme.randomPairs = Theme.themes[Theme.randomInteger]["numberOfCards"] as? Int ?? Theme.emojis.count
        
        model.startNewGame(themeName: Theme.themeName, numberOfPairsOfCards: Theme.randomPairs, cardContentFactory: { (pairIndex: Int) -> String in
            return Theme.emojis[pairIndex]
        })
    }
        
    var modelThemeName: String {
            return model.currentThemeName
        }
    
    var modelScore: String {
        return String(model.score)
    }
}
    
    
