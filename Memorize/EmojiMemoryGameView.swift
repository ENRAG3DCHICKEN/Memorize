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
    }



    struct CardView: View {
        var card: MemoryGame<String>.Card
        
        var body: some View {
            GeometryReader { geometry in
                self.body(for: geometry.size)
            }
        }
            
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5).opacity(0.4)
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .modifier(Cardify(isFaceUp: card.isFaceUp))
            //.cardify(isFaceUp: card.isFaceUp)
        }
    }
    // MARK: - Drawing Contents

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}


















struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
