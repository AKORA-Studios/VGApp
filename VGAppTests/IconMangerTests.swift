//
//  IconMangerTests.swift
//  VGAppTests
//
//  Created by Kiara on 11.07.23.
//

import XCTest
@testable import VGApp
import SwiftUI

class IconMangerTests: XCTestCase {
    
    func test_noIcon() {
        XCTAssertEqual(IconManager.getIcon("nononono"), nil)
    }
    
    func test_IconExists() {
        XCTAssertEqual(IconManager.getIcon("karotte uwu"), Image(systemName: "carrot"))
    }

}
