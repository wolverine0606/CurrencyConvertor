//
//  ContentView.swift
//  CurrencyConvertor
//
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Amount")
                .font(.system(size: 15))
            TextField("", value: $viewModel.baseAmount, formatter: viewModel.numberFormatter)
                .font(.system(size: 18, weight: .semibold))
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.clear)
                        .stroke(Color.gray, lineWidth: 1)
                }
            
            HStack {
                Spacer()
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.vertical)
                Spacer()
            }
            
            Text("Converted To")
                .font(.system(size: 15))
            
            TextField("", value: $viewModel.convertedAmount, formatter: viewModel.numberFormatter)
                .font(.system(size: 18, weight: .semibold))
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.clear)
                        .stroke(Color.gray, lineWidth: 1)
                }
            
            HStack {
                Spacer()
                Text("1.00000 USD = 2.00000 EUR")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 25)
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
