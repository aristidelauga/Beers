//
//  BeerDetail.swift
//  Beers
//
//  Created by Aristide LAUGA on 26/02/2023.
//

import SwiftUI

struct BeerDetail: View {
  @StateObject var beerViewModel = BeerViewModel()
  @FocusState var isTextFieldInUse: Bool
  var beer: Beer
  var body: some View {
    ZStack(alignment: .topTrailing) {
      HStack(spacing: 10) {
        Spacer()
        AsyncImage(url: beer.image) { image in
          image
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
        } placeholder: { ProgressView() }
        Spacer()
        VStack(alignment: .leading, spacing: 10) {
          Text(beer.name)
            .font(.system(.title, weight: .bold))
          Text(beer.formattedTagline)
            .font(.system(.title3, weight: .light))
          Text(beer.description)
        }
        .multilineTextAlignment(.leading)
        .fixedSize(horizontal: false, vertical: true)
        Spacer()
      }
      .foregroundColor(.white)
      .padding(.vertical, 20)
      Button {
        beerViewModel.addToFavoriteBeers(beer)
      } label: {
        Image(systemName: "bookmark.fill")
          .foregroundColor(.yellow)
          .font(.system(size: 35))
          .padding(.trailing, 50)
          .offset(y: -3)
      }
    }
    .alignmentGuide(.trailing) { dimensions in
      dimensions[HorizontalAlignment.trailing]
    }
  }
}

struct BeerDetail_Previews: PreviewProvider {
  static var previews: some View {
    BeerDetail(beer: beerPreview.first!)
      .preferredColorScheme(.dark)
  }
}
