//
//  AfterHookFailureObserver.swift
//  CucumberSwift
//
//
//
//

import Foundation
import XCTest

/// Observer that detects XCTest failures during hook execution.
/// This allows CucumberSwift to automatically capture failures that occur
/// in AfterScenario hooks.
final class AfterHookFailureObserver: NSObject, XCTestObservation {

    // MARK: - Singleton

    static let shared = AfterHookFailureObserver()

    private override init() {
        super.init()
    }

    // MARK: - Properties

    private let lock = NSLock()
    private var isObserving = false
    private var capturedFailureMessage: String?

    // MARK: - Public API

    /// Starts observing for test failures.
    func startObserving() {
        lock.lock()
        defer { lock.unlock() }

        capturedFailureMessage = nil
        if !isObserving {
            XCTestObservationCenter.shared.addTestObserver(self)
            isObserving = true
        }
    }

    /// Stops observing and returns any captured failure message.
    /// - Returns: The failure message if a failure was captured, nil otherwise.
    func stopObservingAndGetFailure() -> String? {
        lock.lock()
        defer { lock.unlock() }

        if isObserving {
            XCTestObservationCenter.shared.removeTestObserver(self)
            isObserving = false
        }

        let message = capturedFailureMessage
        capturedFailureMessage = nil
        return message
    }

    // MARK: - XCTestObservation

    func testCase(_ testCase: XCTestCase, didRecord issue: XCTIssue) {
        lock.lock()
        defer { lock.unlock() }

        // Only capture the first failure
        if capturedFailureMessage == nil {
            capturedFailureMessage = issue.compactDescription
        }
    }
}
