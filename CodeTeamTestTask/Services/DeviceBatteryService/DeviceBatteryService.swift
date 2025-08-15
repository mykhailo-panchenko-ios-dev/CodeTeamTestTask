//
//  Untitled.swift
//  CodeTeamTestTask
//
//  Created by Mike Panchenko on 15.08.2025.
//
import UIKit
/// Device service that provides data about battery level
protocol DeviceBatteryService {
    func getBatteryLevel() -> Float
}

class IDeviceBatteryService: DeviceBatteryService {
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    func getBatteryLevel() -> Float {
        return UIDevice.current.batteryLevel
    }
}
