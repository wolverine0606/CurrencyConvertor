//
//  ContentViewModel.swift
//  CurrencyConvertor
//
//  Created by Dmytro Potapov on 17.04.2025.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var baseAmount = 1.0
    @Published var convertedAmount = 1.0
    @Published var baseCurrency: CurrencyChoice = .Swiss
    @Published var ConvertedCurrency: CurrencyChoice = .Swiss
    @Published var isLoading = false
    @Published var rates: Rates?
    @Published var errorMessage = ""
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter
    }
    
    var conversionRate: Double {
        if
            let rates = rates,
            let baseExchangeRate = rates.rates[baseCurrency.rawValue],
            let convertedExchangeRate = rates.rates[ConvertedCurrency.rawValue]
        {
            return convertedExchangeRate / baseExchangeRate
        }
        return 1
    }

    func fetchRates() async {
        guard let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=a0a2f66f4ad0416ba326599fef403550") else {
            errorMessage = "Could not fetch rates. Please check your internet connection."
            print("API url is not valid")
            return
        }
        let urlRequest = URLRequest(url: url)
        isLoading = true
        do {
            
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            rates = try JSONDecoder().decode(Rates.self, from: data)
            
        } catch {
            errorMessage = "Could not fetch rates. Please check your internet connection."
            print(error.localizedDescription)
        }
        isLoading = false
    }
    
    func convert() {
        if
            let rates = rates,
            let baseExchangeRate = rates.rates[baseCurrency.rawValue],
            let convertedExchangeRate = rates.rates[ConvertedCurrency.rawValue]
        {
            print(baseAmount)
            convertedAmount = (convertedExchangeRate / baseExchangeRate) * baseAmount
        }
    }
}
