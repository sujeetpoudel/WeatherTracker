//
//  WeatherView.swift
//  WeatherTracker
//
//  Created by Sujeet Poudel on 2/2/25.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var searchText = ""
    @State private var previewWeather: WeatherResponse?
    @State private var clickSearchResultCard: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search Location", text: $searchText)
                    .font(.system(size: 15))
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    .padding([.leading, .trailing], 24)
                    .padding(.top, 20)
                    .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 40)
                                    .padding(.top, 20)
                                    .opacity(0.5)
                            }
                        )
                    .onChange(of: searchText) { city in
                        viewModel.fetchWeather(for: city)
                        clickSearchResultCard = false
                    }
            
                if let previewWeather = previewWeather, !clickSearchResultCard, !searchText.isEmpty {
                    SearchCard(weather: previewWeather)
                        .transition(.move(edge: .top))
                        .onTapGesture {
                            clickSearchResultCard = true
                            viewModel.saveCity(city: previewWeather.location.name)
                        }
                } else if let weather = viewModel.weather {
                    WeatherDetailView(weather: weather)
                        .padding()
                } else {
                    Text("No City Selected")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top, 200)
                        .padding()
                    
                    Text("Please Search For A City")
                        .font(.system(size: 15, weight: .bold))

                }
                
                Spacer()
            }
            .onAppear {
                if !viewModel.city.isEmpty {
                    viewModel.fetchWeather(for: viewModel.city)
                }
            }
            .onReceive(viewModel.$weather) { previewWeather in
                if previewWeather != nil {
                    self.previewWeather = previewWeather
                }
            }
        }
    }
}

#Preview {
    WeatherView()
}
