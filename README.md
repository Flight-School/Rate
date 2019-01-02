# Rate

![Build Status](https://api.travis-ci.com/Flight-School/Rate.svg?branch=master)

A ratio of two related quantities,
expressed in terms of an amount of numerator unit per single denominator unit.

This functionality is discussed in Chapter 5 of
[Flight School Guide to Swift Numbers](https://gumroad.com/l/swift-numbers).

## Requirements

- Swift 4.0+

## Installation

### Swift Package Manager

Add the Rate package to your target dependencies in `Package.swift`:

```swift
import PackageDescription

let package = Package(
  name: "YourProject",
  dependencies: [
    .package(
        url: "https://github.com/Flight-School/Rate",
        from: "1.0.0"
    ),
  ]
)
```

Then run the `swift build` command to build your project.

### Carthage

To use Rate in your Xcode project using Carthage,
specify it in `Cartfile`:

```
github "Flight-School/Rate" ~> 1.0.0
```

Then run the `carthage update` command to build the framework,
and drag the built Rate.framework into your Xcode project.

## Usage

One of the shortcomings of the Foundation Unit and Measurement APIs
is the inability to dynamically declare compound units.
This can make it difficult to perform dimensional analysis
and other multi-step calculations.

The `Rate` structure allows you to express the ratio
between two units in a type-safe manner.
Multiplying a measurement with one unit type by a rate
whose denominator is that same unit type causes those types to cancel out,
resulting in a measurement with the numerator type.

For example, volume over time multiplied by time yields volume:

```swift
let flowRate = Rate<UnitVolume, UnitDuration>(value: 84760,
                                               unit: .cubicFeet,
                                                per: .seconds)
let oneDay = Measurement<UnitDuration>(value: 24, unit: .hours)

(flowRate * oneDay).converted(to: .megaliters) // 207371ML
```

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))
