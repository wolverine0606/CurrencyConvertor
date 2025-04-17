//
//  Rates.swift
//  CurrencyConvertor
//
//  Created by Dmytro Potapov on 17.04.2025.
//

import Foundation

struct Rates: Decodable {
    let rates: [String: Double]
}
