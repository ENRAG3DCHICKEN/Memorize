//
//  ContentView.swift
//  Memorize
//
//  Created by user177069 on 6/27/20.
//  Copyright © 2020 CS193p. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    var body: some View {
        
        return HStack(content: {
            
            return ForEach(viewModel.cards, content: { card in
                CardView(card: card).onTapGesture(perform: {
                    self.viewModel.choose(card: card)
                    
                })
            })
                .foregroundColor(Color.orange)
                .padding()
                
        })
        
    }
}
	
struct CardView: View {
    var card: MemoryGame<String>.Card 
    var body: some View {
        
        ZStack(content: {
    
            if card.isFaceUp {
            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth:3)
            Text(card.content).font(Font.largeTitle)
            }
            else {
            RoundedRectangle(cornerRadius: 10.0).fill()
            }
        })
        
    }
}

	struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
