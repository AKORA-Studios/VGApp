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
    let notFoundImage = Image(systemName: "questionmark.diamond")
    
    func test_noIcon() {
        XCTAssertEqual(IconManager.getIcon("nononono"), notFoundImage)
    }
    
    func test_IconExists() {
        print(IconManager.getIcon("karotte uwu"))
        XCTAssertEqual(IconManager.getIcon("karotte uwu"), Image("carrot"))
    }

}
