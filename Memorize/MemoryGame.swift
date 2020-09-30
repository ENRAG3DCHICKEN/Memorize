//
//  MemoryGame.swift
//  Memorize
//
//  Created by user177069 on 6/28/20.
//  Copyright © 2020 CS193p. All rights reserved.
//

import Foundation
import UIKit

struct MemoryGame<CardContent> where CardContent: Equatable {
    var score: Int
    
    
    //Elements below depend on other items before init'd first
    struct Theme: Encodable {
        let themeName: String
        let themeCardPairs: Int
        let cardContents: [String]
        let themeColor: UIColor.RGB
        
        fileprivate init(themeName: String, themeCardPairs: Int, cardContents: [String], themeColor: UIColor) {
            self.themeName = themeName
            self.themeCardPairs = themeCardPairs
            self.cardContents = cardContents
            self.themeColor = themeColor.rgb
        }
        
        var json: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        func printJSON() {
            print("json = \(self.json?.utf8 ?? "nil")")
        }
    }
    

    private(set) var cards: Array<Card>
    var currentThemeName: String
    var currentThemeColor: UIColor
    var currentThemeNumberOfPairs: Int
    var currentCardContents: [String] = []
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        //The following code can also be simplified using "filter"
        get {
            var faceUpCardIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index)
                }
            }
            if faceUpCardIndices.count == 1 {
                return faceUpCardIndices.first
            } else {
                return nil
            }
        }
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = false
                }
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card chose: \(card)")
        
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                else if cards[chosenIndex].content != cards[potentialMatchIndex].content {
                    if cards[chosenIndex].isSeen {
                        score -= 1
                    }
                    if cards[potentialMatchIndex].isSeen{
                        score -= 1
                    }
                    cards[chosenIndex].isSeen = true
                    cards[potentialMatchIndex].isSeen = true
                }
                
                self.cards[chosenIndex].isFaceUp = true
                
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    mutating func startNewGame(themeName: String, numberOfPairsOfCards: Int, themeColor: UIColor, cardContentFactory: (Int) -> CardContent) {
        score = 0
        currentThemeName = themeName
        currentThemeColor = themeColor
        currentThemeNumberOfPairs = numberOfPairsOfCards
        
        cards.removeAll()
        currentCardContents.removeAll()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
            
            currentCardContents.append(content as! String)
        }
        cards.shuffle()
        
        let themeItem = Theme(themeName: themeName, themeCardPairs: numberOfPairsOfCards, cardContents: currentCardContents, themeColor: themeColor)
        themeItem.printJSON()
    }
    
    init(themeName: String, numberOfPairsOfCards: Int, themeColor: UIColor, cardContentFactory: (Int) -> CardContent) {
    

        
        score = 0
        cards = Array<Card>()
        currentThemeName = themeName
        currentThemeColor = themeColor
        currentThemeNumberOfPairs = numberOfPairsOfCards
        
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
            
            currentCardContents.append(content as! String)
        }
        cards.shuffle()
        
        let themeItem = Theme(themeName: themeName, themeCardPairs: numberOfPairsOfCards, cardContents: currentCardContents, themeColor: themeColor)
        themeItem.printJSON()
    }
    
    struct Card: Identifiable {
        
        //Property Observers
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }}}
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }}
        
        var isSeen: Bool = false
        var content: CardContent
        var id: Int
    
        // MARK: - Bonus Time
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
 

