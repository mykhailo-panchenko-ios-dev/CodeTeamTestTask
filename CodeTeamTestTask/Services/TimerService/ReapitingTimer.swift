//
//  ReapitingTimer.swift
//  CodeTeamTestTask
//
//  Created by Mike Panchenko on 15.08.2025.
//

import Foundation

/// Reapiting timer based on DispatchSourceTimer
class ReapitingTimer {
    
    private enum State {
        case suspended
        case resumed
    }
    private var state: State = .suspended
    private let timeInterval: TimeInterval
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    private lazy var timer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now() + self.timeInterval, repeating: self.timeInterval)
        timer.setEventHandler(handler: { [weak self] in
            self?.eventHandler?()
        })
        return timer
    }()

    var eventHandler: (() -> Void)?

    deinit {
        timer.setEventHandler {}
        timer.cancel()
        resume()
        eventHandler = nil
    }

    func resume() {
        if state != .resumed {
            state = .resumed
            timer.resume()
        }
    }

    func suspend() {
        if state != .suspended {
            state = .suspended
            timer.suspend()
        }
    }
}
