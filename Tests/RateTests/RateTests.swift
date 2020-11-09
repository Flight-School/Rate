import XCTest
@testable import Rate

final class RateTests: XCTestCase {
    func testInitialization() {
        let rate = Rate<UnitMass, UnitLength>(value: 1, unit: .kilograms, per: .meters)

        XCTAssertEqual(rate.value, 1)
        XCTAssertEqual(rate.numeratorUnit, .kilograms)
        XCTAssertEqual(rate.denominatorUnit, .meters)
        XCTAssertEqual(rate.symbol, "kg/m")
    }

    func testAddition() {
        let rate = Rate<UnitVolume, UnitDuration>(value: 1, unit: .liters, per: .seconds)
        let sum = rate + rate

        XCTAssertEqual(sum.value, 2)
        XCTAssertEqual(sum.numeratorUnit, .liters)
    }

    func testSubtraction() {
        let rate = Rate<UnitVolume, UnitDuration>(value: 1, unit: .liters, per: .seconds)
        let difference = rate - rate

        XCTAssertEqual(difference.value, 0)
        XCTAssertEqual(difference.numeratorUnit, .liters)
    }

    func testMultiplicationByMeasurement() {
        let rate = Rate<UnitVolume, UnitDuration>(value: 1, unit: .liters, per: .seconds)
        let duration = Measurement<UnitDuration>(value: 1, unit: .minutes)
        let volume = rate * duration

        XCTAssertEqual(volume.value, 60)
        XCTAssertEqual(volume.unit, .liters)
    }

    func testMultiplicationByScalar() {
        let rate = Rate<UnitVolume, UnitDuration>(value: 1, unit: .liters, per: .seconds)
        let scaledRate = rate * 10

        XCTAssertEqual(scaledRate.value, 10)
        XCTAssertEqual(scaledRate.numeratorUnit, .liters)
    }

    func testDivisionByScalar() {
        let rate = Rate<UnitVolume, UnitDuration>(value: 1, unit: .liters, per: .seconds)
        let scaledRate = rate / 10

        XCTAssertEqual(scaledRate.value, 1 / 10)
        XCTAssertEqual(scaledRate.numeratorUnit, .liters)
    }
}
