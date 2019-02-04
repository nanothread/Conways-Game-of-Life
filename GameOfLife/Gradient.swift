//
//  Gradient.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 18/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import SpriteKit

class Gradient {
    /// Each of these values range between 0 and 255
    typealias RGB = (red: CGFloat, green: CGFloat, blue: CGFloat)
    
    var start: RGB {
        didSet {
            difference = Gradient.calculateDifference(between: start, and: end)
        }
    }
    var end: RGB {
        didSet {
            difference = Gradient.calculateDifference(between: start, and: end)
        }
    }
    
    private var difference: RGB
    
    init(start: RGB, end: RGB) {
        assert(Gradient.rgbIsValid(start), "`start` is not valid RGB (values must be in range 0 ... 255)")
        assert(Gradient.rgbIsValid(end), "`end` is not valid RGB (values must be in range 0 ... 255)")

        self.start = start
        self.end = end
        self.difference = Gradient.calculateDifference(between: start, and: end)
    }
    
    func color(forFraction fraction: CGFloat) -> SKColor {
        assert(fraction >= 0 && fraction <= 1, "Gradient fraction is outside of valid range.")
        
        let values = rgbFromStart(forFraction: fraction)
        return SKColor(red: values.red / 255, green: values.green / 255, blue: values.blue / 255, alpha: 1)
    }
    
    /// Should only be called from `color(forFraction: )`
    private func rgbFromStart(forFraction fraction: CGFloat) -> RGB {
        let diff = difference
        return (red: start.red + diff.red * fraction,
                green: start.green + diff.green * fraction,
                blue: start.blue + diff.blue * fraction)
    }
    
    private static func calculateDifference(between start: RGB, and end: RGB) -> RGB {
        return (red: end.red - start.red,
                green: end.green - start.green,
                blue: end.blue - start.blue)
    }
    static func rgbIsValid(_ c: RGB) -> Bool {
        return [c.red, c.green, c.blue].reduce(true) { $0 && $1 >= 0 && $1 <= 255 }
    }
}
