//
//  loadData.swift
//  Beers
//
//  Created by Aristide LAUGA on 26/02/2023.
//

import Foundation

var beerPreview: [Beer] = load("beerPreview.json")

func load<T: Decodable> (_ filename: String) -> T {
  
  let data: Data
  
  guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
    fatalError("Could not locate the file \(filename) in the main bundle")
  }
  do {
    data = try Data(contentsOf: file)
  } catch {
    fatalError("Could not load the file \(file) from the main bundle: \(error)")
  }
  
  do {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError("Could not decode the file \(filename) as a \(T.self) type: \(error)")
  }
}
