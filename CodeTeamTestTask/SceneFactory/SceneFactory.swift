//
//  ViewModelFactory.swift
//  CodeTeamTestTask
//
//  Created by Mike Panchenko on 15.08.2025.
//

/// Factory for creating scenes
class SceneFactory {
    static func makeMainScene() -> MainView {
        let viewModel = MainViewModel(
            deviceBatteryService: IDeviceBatteryService(),
            networkService: INetworkService(),
            timerService: IReapitingBackgroundTimerService())
        return MainView(viewModel: viewModel)
    }
}
