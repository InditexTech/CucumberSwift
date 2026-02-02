//
//  CucumberTestObserver.swift
//  CucumberSwift
//
//  Created by Tyler Thompson on 5/14/21.
//  Copyright © 2021 Tyler Thompson. All rights reserved.
//

import Foundation

public protocol CucumberTestObserver {
    func testSuiteStarted(at: Date)
    func testSuiteFinished(at: Date)
    func didStart(feature: Feature, at date: Date)
    func didStart(scenario: Scenario, at date: Date)
    func didStart(step: Step, at date: Date)

    func didFinish(feature: Feature, result: Reporter.Result, duration: Measurement<UnitDuration>)
    func didFinish(scenario: Scenario, result: Reporter.Result, duration: Measurement<UnitDuration>)
    func didFinish(step: Step, result: Reporter.Result, duration: Measurement<UnitDuration>)
    func didStartBeforeScenario(_ scenario: Scenario, at date: Date)
    func didFinishBeforeScenario(_ scenario: Scenario, result: Reporter.Result, duration: Measurement<UnitDuration>, errorMessage: String?)
    func didStartAfterScenario(_ scenario: Scenario, at date: Date)
    func didFinishAfterScenario(_ scenario: Scenario, result: Reporter.Result, duration: Measurement<UnitDuration>, errorMessage: String?)
}
