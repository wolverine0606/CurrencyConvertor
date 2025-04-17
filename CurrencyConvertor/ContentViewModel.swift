//
//  ContentViewModel.swift
//  CurrencyConvertor
//
//  Created by Dmytro Potapov on 17.04.2025.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var baseAmount = ""
    @Published var convertedAmount = 1.0
    
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = ""
        return numberFormatter
    }
}
