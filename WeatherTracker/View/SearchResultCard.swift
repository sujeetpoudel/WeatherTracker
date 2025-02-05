//
//  SearchResultCard.swift.swift
//  WeatherTracker
//
//  Created by Sujeet Poudel on 2/4/25.
//

import SwiftUI

struct SearchCard: View {
    let weather: WeatherResponse

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 336, height: 117)
            HStack {
                VStack {
                    Text(weather.location.name)
                        .font(.system(size: 25, weight: .bold))
                    
                    Text("\(Int(weather.current.temp_c))°C")
                        .font(.system(size: 60, weight: .bold))
                }
                AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100) // Weather icon size
            }
        }
        .padding()
        
        Spacer()
    }
}

#Preview {
    SearchCard(weather: .init(location: .init(name: "Gainesville"), current: .init(temp_c: 25.0, condition: .init(text: "Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"), humidity: 60, uv: 8.0, feelslike_c: 27.0)))
}
