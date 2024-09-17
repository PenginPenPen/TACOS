//
//  getSteps.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/30.
//
import CoreMotion

class StepCounterActivityTracker {
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    
    func startTracking(stepsHandler: @escaping (Int) -> Void, activityHandler: @escaping (String) -> Void) {
        startActivityUpdates(handler: activityHandler)
        startPedometerUpdates(handler: stepsHandler)
    }
    
    private func startActivityUpdates(handler: @escaping (String) -> Void) {
        activityManager.startActivityUpdates(to: OperationQueue.main) { (data) in
            guard let activity = data else { return }
            DispatchQueue.main.async {
                if activity.running {
                    handler("Run!")
                } else if activity.walking {
                    handler("Walk")
                } else {
                    handler("不明")
//                    SaveCoin(coin: <#T##Int#>)
                }
            }
        }
    }
    private func startPedometerUpdates(handler: @escaping (Int) -> Void) {
        guard CMPedometer.isStepCountingAvailable() else {
            print("このデバイスでは歩数カウントは利用できません")
            return
        }
        
        pedometer.startUpdates(from: Date()) { (data, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let pedometerData = data {
                DispatchQueue.main.async {
                    handler(pedometerData.numberOfSteps.intValue)
                }
            }
        }
    }
    
    func stopTracking() {
        activityManager.stopActivityUpdates()
        pedometer.stopUpdates()
    }
}
