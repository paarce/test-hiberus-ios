//
//  Cards_CR_HiberusTests.swift
//  Cards CR HiberusTests
//
//  Created by Augusto C.P. on 10/28/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import XCTest
@testable import Cards_CR_Hiberus

class Cards_CR_HiberusTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidatorEmail(){
        let text = "acordero@ffff.com"
        let expectedResponse = true
        XCTAssertEqual(expectedResponse, text.isEmail())
    }
    
    

}
