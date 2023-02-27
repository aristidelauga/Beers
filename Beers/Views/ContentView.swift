//
//  ContentView.swift
//  Beers
//
//  Created by Aristide LAUGA on 26/02/2023.
//

import SwiftUI

struct ContentView: View {
  @StateObject var beerVM = BeerViewModel()
  @State private var beer = beerPreview.first!
  @State private var researchText = ""
  @State private var beerDetailOffset: CGFloat = 0.0
  @State private var selectedToPresentDetail = false
  var onCommit: (String) -> Void
  var filteredBeers: [Beer] {
    if researchText == "" {
      return beerVM.beers
    } else {
      return beerVM.beers.filter { beer in
        return beer.name.lowercased().contains(researchText.lowercased())
      }
    }
  }
  var body: some View {
    VStack {
      TopView(researchText: $researchText, onCommit: onCommit)
      Spacer()
      if beerVM.beers.isEmpty {
        ProgressView()
          .task {
            do {
              try await beerVM.beers = beerVM.getBeers()
            } catch {
              fatalError("Couldn't complete the task: \(error)")
            }
          }
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          ScrollViewReader { proxy in
            LazyVStack {
              ForEach(filteredBeers, id: \.id) { beer in
                BeerRow(isSelected: $selectedToPresentDetail, selectedBeer: $beer, offset: $beerDetailOffset, beer: beer)
                  .id(beer.id)
                  .onAppear {
                    if let lastBeer = beerVM.beers.last {
                      let lastIndex = beerVM.beers.count - 1
                      if beer.id == lastBeer.id {
                        Task {
                          do {
                            try await beerVM.getMoreBeers()
                            proxy.scrollTo(lastIndex, anchor: .bottom)
                          } catch {
                            print("Error while loading more beers: \(error)")
                          }
                        }
                      }
                    }
                  }
              }
              if beerVM.isLoading {
                ProgressView()
                  .onAppear {
                    Task {
                      do {
                        try await beerVM.getMoreBeers()
                      } catch {
                        print("Error while loading more beers: \(error)")
                      }
                    }
                  }
              }
            }
          }
        }
      }
      if selectedToPresentDetail {
        if let beer = beer {
          ZStack(alignment: .bottom) {
            VStack {
              BeerDetail(beer: beer)
                .offset(y: beerDetailOffset)
                .edgesIgnoringSafeArea(.all)
            }
            .background(Color.gray.opacity(0.4))
          }
          .cornerRadius(15)
          .edgesIgnoringSafeArea(.bottom)
        }
      }
    }
    .background(Color.black)
    .edgesIgnoringSafeArea(.bottom)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(onCommit: { _ in })
  }
}
