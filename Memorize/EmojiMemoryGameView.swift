//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by user177069 on 6/27/20.
//  Copyright © 2020 CS193p. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    // Portal into the viewModel
    @ObservedObject var viewModel: EmojiMemoryGame
        
    var body: some View {
    
        Group {
            Text("New Game").onTapGesture{
                self.viewModel.startNewGame()
            }
            Text(viewModel.modelScore)
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
            Text(viewModel.modelThemeName)
        }
            .foregroundColor(Color.orange)
            .padding()
            //.aspectRatio(0.67, contentMode: .fit)
    }
	
struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
            
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(self.card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Contents

    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
    
}


}

