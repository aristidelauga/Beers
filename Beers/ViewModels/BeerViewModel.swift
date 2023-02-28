//
//  BeerViewModel.swift
//  Beers
//
//  Created by Aristide LAUGA on 26/02/2023.
//

import Foundation

@MainActor
final class BeerViewModel: ObservableObject {
  @Published var beers = [Beer]()
  @Published var favoriteBeers = [Beer]()
  @Published var isLoading = false
  var page = 1
  
  
  func getBeers() async throws -> [Beer] {
    guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=2&per_page=25") else {
      fatalError("Incomplete or failing URL")
    }
    
    let urlRequest = URLRequest(url: url)
    
    let (data, _) = try await URLSession.shared.data(for: urlRequest)
    
    let decodedData = try JSONDecoder().decode([Beer].self, from: data)
    
    return decodedData
  }
  
  func getMoreBeers() async throws {
    
    guard !isLoading else { return }
    
    guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page + 1)&per_page=25") else {
      fatalError("Incomplete or failing URL while getting more beers")
    }
    
    let urlRequest = URLRequest(url: url)
    
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw fatalError("Error while fetching the data.")
    }
    let newBeers = try JSONDecoder().decode([Beer].self, from: data)
    self.beers += newBeers
    self.page = 1
    isLoading = false
  }
  
  func addToFavoriteBeers(_ selectedBeer: Beer) {
    if !favoriteBeers.contains(where: { beer in
      selectedBeer.id == beer.id
    }) {
      favoriteBeers.append(selectedBeer)
    }
  }
}
