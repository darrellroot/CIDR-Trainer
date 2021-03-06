//
//  CIDR_TrainerTests.swift
//  CIDR TrainerTests
//
//  Created by Darrell Root on 2/18/22.
//

import XCTest
import Network

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
    
    func testUInt16hex4() throws {
        let test = UInt16(0x1234)
        XCTAssert(test.hex4 == "1234")
    }
    
    func testv61281() throws {
        let input: UInt128 = 1
        let address = IPv6Address(uint128: input)
        XCTAssert(address.description == "::1")
    }
    
    func testv6Description1() throws {
        let description = IPv6Address("ff02:75c8::")!.description
        XCTAssert(description == "ff02:75c8:0000:0000:0000:0000:0000:0000")
    }
    
    func testv6Description2() throws {
        let description = IPv6Address("ff82:4bb8::3")!.description
        XCTAssert(description == "ff82:4bb8:0000:0000:0000:0000:0000:0003")
    }
    
    func testv6Description3() throws {
        let description = IPv6Address("ff82:0000::3")!.description
        XCTAssert(description == "ff82::3")
    }
    
    func testv6Description4() throws {
        let description = IPv6Address("ff82:0008::3")!.description
        XCTAssert(description == "ff82:0008:0000:0000:0000:0000:0000:0003")
    }

    func testInvalidv6() throws {
        for _ in 0..<100 {
            let candidate = InvalidIPv6Address()
            let address = IPv6Address(candidate.value)
            print("\(candidate.value) \(candidate.type)")
            if candidate.type == .valid {
                XCTAssert(address != nil)
            } else {
                XCTAssert(address == nil)
            }
        }
    }

    
    func testv61282() throws {
        let input: UInt128 = UInt128(upperBits: 0xff00_0000_0000_0000, lowerBits: 0)
        let address = IPv6Address(uint128: input)
        XCTAssert(address.description == "ff00::")
    }
    
    func testUInt16hex41() throws {
        let test = UInt16(0x234)
        XCTAssert(test.hex4 == "0234")
    }
    func testUInt16hex42() throws {
        let test = UInt16(0x34)
        XCTAssert(test.hex4 == "0034")
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

    func testNetworkIp() throws {
        let cidr = IPv4Cidr(ip: 4, prefixLength: 30)
        XCTAssert(cidr.networkIp == 4)
    }
    
    func testNetworkIp2() throws {
        let cidr = IPv4Cidr(ip: 5, prefixLength: 30)
        XCTAssert(cidr.networkIp == 4)
    }

    func testWellFormed() throws {
        let cidr = IPv4Cidr(ip: 8, prefixLength: 30)
        XCTAssert(cidr.wellFormed.ip == 8)
    }
    
    func testWellFormed2() throws {
        let cidr = IPv4Cidr(ip: 9, prefixLength: 30)
        XCTAssert(cidr.wellFormed.ip == 8)
    }
    
    func testLastIp1() throws {
        let cidr = IPv4Cidr(ip: 8, prefixLength: 30)
        XCTAssert(cidr.lastUsableIp == 10)
    }
    
    func testLastIp2() throws {
        let cidr = IPv4Cidr(ip: 11, prefixLength: 30)
        XCTAssert(cidr.lastUsableIp == 10)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
