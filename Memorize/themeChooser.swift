//
//  PaletteChooser.swift
//  EmojiArt
//
//  Created by ENRAG3DCHICKEN on 2020-09-25.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI

struct themeChooser: View {



    var body: some View {

        NavigationView {
            List {
                ForEach(themes.availableThemes) { theme in
                    NavigationLink(theme.name, destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme)))
                        .navigationBarTitle("Memorize")
                }
            }
        }
    }
}


