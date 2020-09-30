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
        ["names":"Halloween", "emojis": ["👻","🎃","🕷","☠️","👽"], "numberOfCards": 5, "colors" : UIColor.systemOrange],
        ["names":"Faces", "emojis": ["😀","😍","☹️","😎","😇"], "numberOfCards": 5, "colors" : UIColor.systemYellow],
        ["names":"Sports", "emojis": ["⚽️","🏈","🥎","🎱","🏓"], "numberOfCards": 5, "colors" : UIColor.systemGreen],
        ["names":"Animals", "emojis": ["🦄","🐧","🐼","🙀","🦊"], "numberOfCards": 5, "colors" : UIColor.systemTeal],
        ["names":"Hearts", "emojis": ["❤️","🧡","💛","💚","💙","💜","🖤","🤍","🤎"], "colors" : UIColor.systemRed],
        ["names":"Food", "emojis": ["🍏","🥑","🥦","🥐","🌭"], "numberOfCards": 5, "colors" : UIColor.systemBlue]
    ]
     
    static var randomInteger = Int.random(in: 0..<themes.count)
    static var themeName: String = themes[randomInteger]["names"] as! String
    static var emojis: Array<String> = themes[randomInteger]["emojis"]  as! [String]
    static var randomPairs = themes[randomInteger]["numberOfCards"] as? Int ?? emojis.count
    
    static var themeColor = themes[randomInteger]["colors"] as! UIColor
    
 }
 
 class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame(themeName: Theme.themeName, emojis: Theme.emojis, randomPairs: Theme.randomPairs, colors: Theme.themeColor)
        
    private static func createMemoryGame(themeName: String, emojis: [String], randomPairs: Int, colors: UIColor) -> MemoryGame<String> {

        return MemoryGame<String>(themeName: themeName, numberOfPairsOfCards: randomPairs, themeColor: colors, cardContentFactory: { (pairIndex: Int) -> String in
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
        Theme.themeColor = Theme.themes[Theme.randomInteger]["colors"] as! UIColor
        
        model.startNewGame(themeName: Theme.themeName, numberOfPairsOfCards: Theme.randomPairs, themeColor: Theme.themeColor, cardContentFactory: { (pairIndex: Int) -> String in
            return Theme.emojis[pairIndex]
        })
    }
        
    var modelThemeName: String {
            return model.currentThemeName
        }
    
    var modelThemeColor: UIColor {
        return model.currentThemeColor
    }
    
    var modelScore: String {
        return String(model.score)
    }
}
    
