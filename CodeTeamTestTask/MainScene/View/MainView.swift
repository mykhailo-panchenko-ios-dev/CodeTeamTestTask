//
//  ContentView.swift
//  CodeTeamTestTask
//
//  Created by Mike Panchenko on 15.08.2025.
//

import SwiftUI

struct MainView: View {
    private var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    MainView(viewModel: MainViewModel(deviceBatteryService: IDeviceBatteryService(),
                                      networkService: INetworkService(),
                                      timerService: IReapitingBackgroundTimerService()))
}
