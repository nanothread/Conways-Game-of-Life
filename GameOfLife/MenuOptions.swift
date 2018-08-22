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

// From https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
extension UIColor {
    public convenience init(hex hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        self.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
