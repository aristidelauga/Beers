//
//  TopView.swift
//  Beers
//
//  Created by Aristide LAUGA on 26/02/2023.
//

import SwiftUI

struct TopView: View {
  @StateObject var beerVM = BeerViewModel()
  @Binding var researchText: String
  @FocusState private var textFieldinUse: Bool
  var onCommit: (String) -> Void
  var body: some View {
    VStack {
      Text("Beer **Box**")
        .font(.system(.title))
        .foregroundColor(.white)
      HStack {
        Button {
          self.onCommit(researchText)
          textFieldinUse = false
        } label: {
          Image(systemName: "magnifyingglass")
            .imageScale(.large)
            .offset(x: 7)
            .foregroundColor(.white.opacity(0.7))
        }
        TextField("Search for a beer", text: $researchText, onCommit: {
          self.onCommit(researchText)
          textFieldinUse = false
        })
        .padding()
        .foregroundColor(.white)
        .submitLabel(.search)
        .focused($textFieldinUse)
      }
      .background(Color.gray.opacity(0.2))
      .cornerRadius(10)
      .padding(5)
      HStack(spacing: 15) {
        Spacer()
        VStack(alignment: .leading) {
          Text("**Weekend Offers**")
          Text("Free shipping on orders over 60€")
        }
        .foregroundColor(.black)
        Spacer()
        Image("gift")
          .resizable()
          .scaledToFill()
          .frame(width: 80, height: 80)
          .padding(.bottom, 10)
        Spacer()
      }
      .background(Color(#colorLiteral(red: 0.9882352941, green: 0.6862745098, blue: 0.1960784314, alpha: 1)))
      .cornerRadius(15)
    }
  }
}

struct TopView_Previews: PreviewProvider {
  static var previews: some View {
    TopView(researchText: .constant(""), onCommit: { _ in })
  }
}
