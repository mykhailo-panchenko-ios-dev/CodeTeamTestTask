//
//  MainViewModel.swift
//  CodeTeamTestTask
//
//  Created by Mike Panchenko on 15.08.2025.
//

import Foundation
import Combine
import UIKit

class MainViewModel {
    private let deviceBatteryService: DeviceBatteryService
    private let networkService: NetworkService
    private let timerService: ReapitingBackgroundTimerService
    private var cancellables: Set<AnyCancellable> = []
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    
    init(deviceBatteryService: DeviceBatteryService,
         networkService: NetworkService,
         timerService: ReapitingBackgroundTimerService) {
        self.deviceBatteryService = deviceBatteryService
        self.networkService = networkService
        self.timerService = timerService
        self.sendData()
        self.startMonitoringData()
    }
    /// Start timer for getting and uploading data from device
    private func startMonitoringData() {
        timerService.makeReapitingTimer(timeInterval: 120) { [weak self] in
            self?.startBackgroundTask()
            self?.sendData()
        }
    }
    
    /// Start background task
    private func startBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "BatteryMonitoring",
                                                                  expirationHandler: {
            self.finishBackgroundTask()
        })
    }
    
    
    
    private func finishBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }

    private func sendData() {
        let batteryLevel = deviceBatteryService.getBatteryLevel()
        let model = DeviceInfoModel(time: Date(), batteryLevel: batteryLevel)
        networkService.sendBatteryLevel(model: model)
            .sink { [weak self] result in
                switch result {
                case .finished:
                    print("Success")
                case .failure(let error):
                    switch error {
                    case .encodeError:
                        print("Encoding Failure")
                    case .networkError(let errorCode):
                        print("Network Error: \(errorCode)")
                    case .wrongURL:
                        print("Wrong URL")
                    }
                }
                self?.finishBackgroundTask()
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    deinit {
        finishBackgroundTask()
    }
}
