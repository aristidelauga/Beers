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

extension Beer: Equatable {
  static func == (lhs: Beer, rhs: Beer) -> Bool {
    return lhs.id == rhs.id &&
    lhs.name == rhs.name &&
    lhs.tagline == rhs.tagline &&
    lhs.description == rhs.description &&
    lhs.image_url == rhs.image_url &&
    lhs.formattedTagline == rhs.formattedTagline &&
    lhs.image == rhs.image
  }
}
