//
//  CIDR_TrainerTests.swift
//  CIDR TrainerTests
//
//  Created by Darrell Root on 2/18/22.
//

import XCTest

class CIDR_TrainerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCidrBinary32bit() throws {
        let cidr = IPv4Cidr(ip: 0, prefixLength: 0)
        // binary string should be 32 chars
        //print(cidr.binary.count)
        XCTAssert(cidr.binary.count == 32)
    }
    
    func testCidrBinary32zero() throws {
        let cidr = IPv4Cidr(ip: 0, prefixLength: 0)
        // binary string should be 32 chars
        XCTAssert(cidr.binary == "00000000000000000000000000000000")
    }
    
    func testCidrBinary32ones() throws {
        let cidr = IPv4Cidr(ip: UINT32_MAX, prefixLength: 32)
        // binary string should be 32 chars
        XCTAssert(cidr.binary == "11111111111111111111111111111111")
    }
    
    func testCidrBinary24() throws {
        let cidr = IPv4Cidr(ip: UINT32_MAX, prefixLength: 24)
        //print(cidr.maskBinary)
        XCTAssert(cidr.maskBinary == "11111111111111111111111100000000")
    }
    
    func testCidrBinary26Space() throws {
        let cidr = IPv4Cidr(ip: UINT32_MAX, prefixLength: 26)
        //print(cidr.maskBinary)
        XCTAssert(cidr.maskBinarySpace == "11111111 11111111 11111111 11000000")
    }
    
    func testCidrBinarySpace() throws {
        let cidr = IPv4Cidr(ip: UINT32_MAX, prefixLength: 26)
        //print(cidr.maskBinary)
        XCTAssert(cidr.binarySpace == "11111111 11111111 11111111 11111111")
    }


    
    func testNumberIps() throws {
        let cidr = IPv4Cidr(ip: 0, prefixLength: 24)
        XCTAssert(cidr.numberIps == 256)
    }
    
    func testNumberUsableIps() throws {
        let cidr = IPv4Cidr(ip: 0, prefixLength: 25)
        XCTAssert(cidr.numberUsableIps == 126)
    }



 

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
