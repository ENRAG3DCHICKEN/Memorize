	 //
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by user177069 on 6/28/20.
//  Copyright © 2020 CS193p. All rights reserved.
//

import SwiftUI
 
struct Theme: Identifiable {
    
    var id: UUID

    var name: String
    var emojis: [String]
    var numberOfCards: Int? = nil
    var color: UIColor
    
    init (name: String, emojis: [String], numberOfCards: Int? = nil, color: UIColor) {
        self.name = name
        self.emojis = emojis
        self.numberOfCards = numberOfCards
        self.color = color
        self.id = UUID()
    }
}
    
    
        
  
struct themes {
        
    static var availableThemes: [Theme] = [
        Theme(name: "Halloween", emojis: ["👻","🎃","🕷","☠️","👽"], numberOfCards: 5, color: UIColor.systemOrange),
        Theme(name: "Faces", emojis: ["😀","😍","☹️","😎","😇"], numberOfCards: 5, color: UIColor.systemYellow),
        Theme(name: "Sports", emojis: ["⚽️","🏈","🥎","🎱","🏓"], numberOfCards: 5, color: UIColor.systemGreen),
        Theme(name: "Animals", emojis: ["🦄","🐧","🐼","🙀","🦊"], numberOfCards: 5, color: UIColor.systemTeal),
        Theme(name: "Hearts", emojis: ["❤️","🧡","💛","💚","💙","💜","🖤","🤍","🤎"], numberOfCards: 9, color: UIColor.systemRed),
        Theme(name: "Food", emojis: ["🍏","🥑","🥦","🥐","🌭"], numberOfCards: 5, color: UIColor.systemBlue)
    ]

    static var selectedTheme: Theme = availableThemes[Int.random(in: 0..<availableThemes.count)]
 
}
     
 class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame(themeName: themes.selectedTheme.name, emojis: themes.selectedTheme.emojis, randomPairs: themes.selectedTheme.numberOfCards!, colors: themes.selectedTheme.color)
        
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
        
        themes.selectedTheme = themes.availableThemes[Int.random(in: 0..<themes.availableThemes.count)]
        
        model.startNewGame(themeName: themes.selectedTheme.name, numberOfPairsOfCards: themes.selectedTheme.numberOfCards!, themeColor: themes.selectedTheme.color, cardContentFactory: { (pairIndex: Int) -> String in
            return themes.selectedTheme.emojis[pairIndex]
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
     
    
