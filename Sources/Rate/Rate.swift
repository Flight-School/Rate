import Foundation

/**
 A ratio of two related quantities,
 expressed in terms of an amount of numerator unit per single denominator unit.
 */
public struct Rate<Numerator, Denominator> where Numerator: Unit, Denominator: Unit {
    /// The value of the numerator unit per single denominator unit.
    public var value: Double

    /// The numerator unit.
    public var numeratorUnit: Numerator

    /// The denominator unit.
    public var denominatorUnit: Denominator

    /// The rate symbol.
    public var symbol: String {
        return "\(self.numeratorUnit.symbol)/\(self.denominatorUnit.symbol)"
    }

    /**
     Creates a new rate from a value,
     and specified numerator and denominator units.

     - Parameters:
        - value: The value of the numerator unit per single denominator unit.
        - unit: The numerator unit.
        - per: The denominator unit.
     */
    public init(value: Double, unit numeratorUnit: Numerator, per denominatorUnit: Denominator) {
        self.value = value
        self.numeratorUnit = numeratorUnit
        self.denominatorUnit = denominatorUnit
    }

    /**
     Creates a new rate from specified numerator and denominator measurements.

     - Parameters:
        - numerator: The numerator measurement.
        - denominator: The denominator measurement.
     - Precondition: The value of `denominator` must be greater than 0.
     */
    public init(_ numerator: Measurement<Numerator>, per denominator: Measurement<Denominator>) {
        precondition(denominator.value > 0)
        let value = numerator.value / denominator.value
        self.init(value: value, unit: numerator.unit, per: denominator.unit)
    }

    /**
     Returns the product of the rate multiplied by the specified value.

     - Parameters:
        - by: The value to multiply the rate by.
     */
    public func multiplied(by scalar: Double) -> Rate<Numerator, Denominator> {
        return .init(value: self.value * scalar, unit: self.numeratorUnit, per: self.denominatorUnit)
    }

    /**
     Returns the quotient of the rate divided by the specified value.

     - Parameters:
        - by: The value to divide the rate by.
     */
    public func divided(by scalar: Double) -> Rate<Numerator, Denominator> {
        return .init(value: self.value / scalar, unit: self.numeratorUnit, per: self.denominatorUnit)
    }
}

extension Rate where Numerator: Dimension, Denominator: Dimension {
    /**
     Returns the sum of this rate and the specified rate.

     - Parameters:
        - rate: The rate to add to this rate.
     */
    public func adding(_ rate: Rate<Numerator, Denominator>) -> Rate<Numerator, Denominator> {
        return .init(value: self.value + self.numeratorUnit.converter.value(fromBaseUnitValue: rate.numeratorUnit.converter.baseUnitValue(fromValue: rate.value)), unit: self.numeratorUnit, per: self.denominatorUnit)
    }

    /**
     Returns the difference between this rate and the specified rate.

     - Parameters:
        - rate: The rate to add to this rate.
     */
    public func subtracting(_ rate: Rate<Numerator, Denominator>) -> Rate<Numerator, Denominator> {
        return .init(value: self.value - self.numeratorUnit.converter.value(fromBaseUnitValue: rate.numeratorUnit.converter.baseUnitValue(fromValue: rate.value)), unit: self.numeratorUnit, per: self.denominatorUnit)
    }

    /**
     Returns the product of this rate multiplied by the specified measurement.

     - Parameters:
        - by: The measurement to multiply this rate by.
     */
    public func multiplied(by measurement: Measurement<Denominator>) -> Measurement<Numerator> {
        return .init(value: Measurement(value: self.value, unit: measurement.unit).converted(to: self.denominatorUnit).value * measurement.value, unit: self.numeratorUnit)
    }
}

extension Rate: CustomStringConvertible {
    public var description: String {
        return "\(self.value) \(self.symbol)"
    }
}

public func + <T, U>(lhs: Rate<T,U>, rhs: Rate<T,U>) -> Rate<T,U> where T: Dimension, U: Dimension {
    return lhs.adding(rhs)
}

public func - <T, U>(lhs: Rate<T,U>, rhs: Rate<T,U>) -> Rate<T,U> where T: Dimension, U: Dimension {
    return lhs.subtracting(rhs)
}

public func * <T, U>(lhs: Rate<T,U>, rhs: Double) -> Rate<T,U> where T: Dimension, U: Dimension {
    return lhs.multiplied(by: rhs)
}

public func / <T, U>(lhs: Rate<T,U>, rhs: Double) -> Rate<T,U> where T: Dimension, U: Dimension {
    return lhs.divided(by: rhs)
}

public func * <T, U>(lhs: Rate<T,U>, rhs: Measurement<U>) -> Measurement<T> where T: Dimension, U: Dimension {
    return lhs.multiplied(by: rhs)
}

public func * <T, U>(lhs: Measurement<U>, rhs: Rate<T,U>) -> Measurement<T> where T: Dimension, U: Dimension {
    return rhs.multiplied(by: lhs)
}
