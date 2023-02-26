//
//  Beer.swift
//  Beers
//
//  Created by Aristide LAUGA on 26/02/2023.
//

import Foundation


struct Beer: Codable {
  let id: Int
  let name, tagline, description, image_url: String
  var formattedTagline: String {
    if tagline.hasSuffix(".") {
      let newTagline = tagline.dropLast()
      return String(newTagline)
    } else { return tagline }
    
  }
  var image: URL {
    let urlString = URL(string: image_url)
    return urlString ?? URL(string: "https://images.punkapi.com/v2/5.png")!
  }
}
