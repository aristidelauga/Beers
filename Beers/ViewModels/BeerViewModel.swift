//
//  BeerViewModel.swift
//  Beers
//
//  Created by Aristide LAUGA on 26/02/2023.
//

import Foundation

@MainActor
final class BeerViewModel: ObservableObject {
  @Published var beers = [Beers]()
  @Published var favoriteBeers = [Beer]()
  @Published var isLoading = false
  var page = 1
  
  
  func getBeers() async throws -> [Beer] {
    guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=2&per_page=25") else {
      fatalError("Incomplete or failing URL")
    }
  }
}
