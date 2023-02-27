//
//  BeerRow.swift
//  Beers
//
//  Created by Aristide LAUGA on 26/02/2023.
//

import SwiftUI

struct BeerRow: View {
  @Binding var isSelected: Bool
  @Binding var selectedBeer: Beer
  @Binding var offset: CGFloat
  var beer: Beer
  var body: some View {
    HStack(spacing: 15) {
      Spacer()
      AsyncImage(url: beer.image) { image in
        image
          .resizable()
          .scaledToFit()
          .frame(width: 80, height: 80)
      } placeholder: {
        ProgressView()
      }
      VStack(alignment: .leading, spacing: 5) {
        Text(beer.name)
          .font(.system(.title3, weight: .bold))
        Text(beer.formattedTagline)
        Text(beer.description)
          .lineLimit(2)
          .foregroundColor(.gray)
          .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
        Button {
          withAnimation(.spring()) {
            if selectedBeer != beer {
              selectedBeer = beer
              isSelected = true
            } else {
              isSelected = false
              selectedBeer = beerPreview.first!
            }
          }
        } label: {
          Text("MORE INFO")
            .foregroundColor(.yellow)
        }
      }
      Spacer()
    }
    .foregroundColor(.white)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct BeerRow_Previews: PreviewProvider {
  static var previews: some View {
    BeerRow(isSelected: .constant(.random()), selectedBeer: .constant(beerPreview.first!), offset: .constant(0.0), beer: beerPreview.first!)
      .preferredColorScheme(.dark)
  }
}
