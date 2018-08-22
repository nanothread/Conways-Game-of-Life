//
//  MenuOptions.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 22/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import UIKit

extension MenuOption {
    enum Action: String, Codable {
        case clearBoard, setCellStates, viewPredefinedPatterns, jumpToTick, selectTheme, changeBoardSize, saveGame, loadGame, shareGame, viewMusicOptions, viewFineSettings, editMenu
    }
}

struct MenuOption: Codable {
    var name: String
    var action: Action
    var colorString: String
    var iconName: String
    // Consider adding one for icon size
    
    var color: UIColor {
        return UIColor(hex: colorString)
    }
    var icon: UIImage {
        return UIImage(named: iconName)!
    }
}

extension MenuOption {
    static func loadOptionsFromBundle() -> [MenuOption] {
        guard let url = Bundle.main.url(forResource: "MenuOptions", withExtension: "json") else {
            print("Resource path isn't a URL.")
            return []
        }
        
        do {
            guard let data = try String(contentsOf: url).data(using: .utf8) else {
                print("Data could not be extracted from url")
                return []
            }
            
            return try JSONDecoder().decode([MenuOption].self, from: data)
        }
        catch {
            print("Error loading options from JSON file:", error.localizedDescription)
        }
        
        return []
    }
}

// From source code of https://github.com/hyperoslo/Hue
extension UIColor {
    convenience init(hex string: String) {
        var hex = string.hasPrefix("#")
            ? String(string.dropFirst())
            : string
        guard hex.count == 3 || hex.count == 6
            else {
                self.init(white: 1.0, alpha: 0.0)
                return
        }
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        self.init(
            red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: 1.0)
    }
}
