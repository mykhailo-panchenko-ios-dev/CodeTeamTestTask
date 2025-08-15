//
//  TimerService.swift
//  CodeTeamTestTask
//
//  Created by Mike Panchenko on 15.08.2025.
//

import Foundation

/// Reapiting background timer service
protocol ReapitingBackgroundTimerService {
    func makeReapitingTimer(timeInterval: TimeInterval,
                            eventHandler: @escaping () -> Void)
}

class IReapitingBackgroundTimerService: ReapitingBackgroundTimerService {
    private var timer: ReapitingTimer?
    
    func makeReapitingTimer(timeInterval: TimeInterval,
                            eventHandler: @escaping () -> Void) {
        timer = ReapitingTimer(timeInterval: timeInterval)
        timer?.eventHandler = eventHandler
        timer?.resume()
    }
}
