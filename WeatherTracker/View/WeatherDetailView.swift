//
//  WeatherDetailView.swift
//  WeatherTracker
//
//  Created by Sujeet Poudel on 2/4/25.
//

import SwiftUI

struct WeatherDetailView: View {
    let weather: WeatherResponse

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 123, height: 123)

            Text(weather.location.name)
                .font(.system(size: 30, weight: .bold))
            
            Text("\(Int(weather.current.temp_c))°")
                .font(.system(size: 70, weight: .bold))
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.15))
                    .frame(width: 274, height: 75)
                
                HStack {
        
                    VStack {
                        Text("Humidity ")
                            .foregroundColor(.gray).opacity(0.7)
                        Text("\(weather.current.humidity)%")
                            .foregroundColor(.gray).opacity(0.9)
                    }
        
                    VStack {
                        Text("UV")
                            .foregroundColor(.gray).opacity(0.7)
                        Text("\(Int(weather.current.uv))")
                            .foregroundColor(.gray).opacity(0.9)
                    }
                    
                    
                    VStack {
                        Text("Feels Like")
                            .foregroundColor(.gray).opacity(0.7)
                        Text("\(Int(weather.current.feelslike_c))°")
                            .foregroundColor(.gray).opacity(0.9)
                    }
                    
                    
                }
            }
            Spacer()
        }
    }
}

#Preview {
    WeatherDetailView(weather: .init(location: .init(name: "Gainesville"), current: .init(temp_c: 25.0, condition: .init(text: "Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"), humidity: 60, uv: 8.0, feelslike_c: 27.0)))
}
