//
//  ContentView.swift
//  Memorize
//
//  Created by Matheus Dubberstein da Silva on 30/01/24.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount: Int = 4
    let emojis: [String] = ["🐵", "🐷", "🦊", "🐸", "🐶","🐭", "🐥", "🦁", "🐢", "🐔" , "🦆"]
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
        }
        .padding()
            
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], content: {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }).foregroundColor(.orange)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action:  {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        }).disabled(cardCount + offset > emojis.count || cardCount + offset < 1)
    }
    
    var cardAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
            
        }.imageScale(.large).font(.largeTitle)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.fill.badge.plus")
    }
}


struct CardView: View {
    @State var isFaceUp: Bool = false
    let content: String
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2).foregroundColor(.orange)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
