//
//  StringExtensionsTests.swift
//  CucumberSwiftTests
//
//  Created by Tyler Thompson on 4/8/18.
//  Copyright © 2018 Tyler Thompson. All rights reserved.
//

import Foundation
import XCTest
@testable import CucumberSwift

class StringExtensionsTests: XCTestCase {
    func testMatchesReturnsCorrectMatchesForRegex() {
        let matches = "This is a test".matches(for: "^(.*?) is a test$")
        XCTAssertEqual(matches.count, 2)
        XCTAssertEqual(matches.first, "This is a test")
        XCTAssertEqual(matches.last, "This")
    }

    func testMatchesReturnsAnEmptyArrayForInvalidRegex() {
        let matches = "This is a test".matches(for: "^(.*? is a test$")
        XCTAssertEqual(matches.count, 0)
    }

    func testMatchesReturnsAnEmptyArrayForNonMatchingRegex() {
        let matches = "This is a test".matches(for: "^xc7qqv....$")
        XCTAssertEqual(matches.count, 0)
    }

    func testCapitalizingFirstLetter() {
        XCTAssertEqual("test".capitalizingFirstLetter(), "Test")
    }

    func testLowercasingFirstLetter() {
        XCTAssertEqual("Test".lowercasingFirstLetter(), "test")
    }

    func testCamelCaseFromSpaces() {
        XCTAssertEqual("test one".camelCasingString(), "testOne")
    }

    func testCamelCaseFromNonAlphanumericCharacters() {
        XCTAssertEqual("test-two".camelCasingString(), "testTwo")
    }

    func testInitWithStaticString() {
        let ss: StaticString = "someValue"
        XCTAssertEqual(String(ss), "someValue")
    }

    func testMatchesReturnsEmptyArrayForInvalidRegex() {
        let matches = "This is a test".matches(for: "[")
        XCTAssertEqual(matches.count, 0)
    }

    func testStableHashReturnsConsistentValues() {
        let str1 = "FeatureURI"
        let str2 = "FeatureURI"
        let str3 = "AnotherFeatureURI"

        XCTAssertEqual(str1.stableHash, str2.stableHash, "Hash should be deterministic for same string")
        XCTAssertNotEqual(str1.stableHash, str3.stableHash, "Hash should likely differ for diff strings")
    }

    func testStableHashIsSpecificValue() {
        // Known djb2 collision/value check
        // hash(5381) -> 'a'(97) -> 177670
        let val = "a".stableHash
        // 5381 * 33 + 97 = 177573 + 97 = 177670
        XCTAssertEqual(val, 177670)
    }
}
