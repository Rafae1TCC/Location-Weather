//
//  ContentView.swift
//  Location
//
//  Created by Rafael Cabrera on 8/27/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel:LocationViewModel = LocationViewModel()
    @StateObject var weatherViewModel:WeatherViewModel = WeatherViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Group {
                        if viewModel.currentViewState == .needPermission {
                            PermissionView(onEnable: {viewModel.enableLocationButton()})
                        } else if viewModel.currentViewState == .loading{
                            LoadingView()
                        } else if viewModel.currentViewState == .ready{
                            LocationReadyView(latText: viewModel.latText, lonText: viewModel.lonText, onRefresh: {viewModel.refresh()}, onSave: {viewModel.saveCheckIn()})
                            WeatherView(weatherViewModel: weatherViewModel)
                        } else if viewModel.currentViewState == .failed {
                            FailedView(message: viewModel.errorMessage, tryAgain: {viewModel.enableLocationButton()})
                        } else if viewModel.currentViewState == .denied {
                            DeniedView(message: viewModel.errorMessage)
                        }
                    }

                    ListView(checkIns: viewModel.checkIns, onClearAll: {viewModel.clearAll()})
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Location Weather")
        }
        .onAppear {
            // Hook location updates to weather fetches (Views stay free of networking/location logic)
            viewModel.onLocationReady = { coordinate in
                weatherViewModel.fetchWeather(coordinate: coordinate)
            }
        }
    }
}
#Preview {
    ContentView()
}
