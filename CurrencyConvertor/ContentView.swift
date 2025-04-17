//
//  ContentView.swift
//  CurrencyConvertor
//
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    @FocusState private var baseAmountIsFocused: Bool
    @FocusState private var convertedAmountIsFocused: Bool
    
    var body: some View {
        ZStack {
            Color.clear
                   .contentShape(Rectangle()) // ensures the whole area is tappable
                   .onTapGesture {
                       print("tap")
                       viewModel.convert()
                       baseAmountIsFocused = false
                       convertedAmountIsFocused = false
                   }
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.red)
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                }
                Text("Amount")
                    .font(.system(size: 15))
                TextField("", value: $viewModel.baseAmount, formatter: viewModel.numberFormatter)
                    .focused($baseAmountIsFocused)
                    .onSubmit {
                        viewModel.convert()
                        baseAmountIsFocused = false
                        convertedAmountIsFocused = false
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.clear)
                            .stroke(Color.gray, lineWidth: 1)
                    }
                    .overlay(alignment: .trailing) {
                        HStack {
                            viewModel.baseCurrency.image()
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                            
                            Menu {
                                ForEach(CurrencyChoice.allCases) { currencyChoice in
                                    Button {
                                        viewModel.baseCurrency = currencyChoice
                                        viewModel.convert()
                                        
                                    } label: {
                                        Text(currencyChoice.fetchMenuName())
                                    }
                                }
                            } label: {
                                Text(viewModel.baseCurrency.rawValue)
                                
                                Image(systemName: "chevron.down")
                            }
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .bold))
                            
                        }
                        .padding(.trailing)
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
                    .focused($convertedAmountIsFocused)
                    .font(.system(size: 18, weight: .semibold))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.clear)
                            .stroke(Color.gray, lineWidth: 1)
                    }
                    .overlay(alignment: .trailing) {
                        HStack {
                            viewModel.ConvertedCurrency.image()
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                            
                            Menu {
                                ForEach(CurrencyChoice.allCases) { currencyChoice in
                                    Button {
                                        viewModel.ConvertedCurrency = currencyChoice
                                        viewModel.convert()
                                    } label: {
                                        Text(currencyChoice.fetchMenuName())
                                    }
                                }
                            } label: {
                                Text(viewModel.ConvertedCurrency.rawValue)
                                
                                Image(systemName: "chevron.down")
                            }
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .bold))
                            
                        }
                        .padding(.trailing)
                    }
                
                HStack {
                    Spacer()
                    Text("1.00000 \(viewModel.baseCurrency.rawValue) = \(viewModel.conversionRate) \(viewModel.ConvertedCurrency.rawValue)")
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.top, 25)
                    Spacer()
                }
            }
            .padding(.horizontal)
            .task {
                await viewModel.fetchRates()
            }
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView()
                        .tint(.white)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
