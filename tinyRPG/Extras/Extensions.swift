//
//  Extensions.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/21/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation
import AppKit

extension NSBitmapImageRep {
    var png: Data? {
        return representation(using: .png, properties: [:])
    }
}
extension Data {
    var bitmap: NSBitmapImageRep? {
        return NSBitmapImageRep(data: self)
    }
}
extension NSImage {
    var png: Data? {
        return tiffRepresentation?.bitmap?.png
    }
    func savePNG(to url: URL) -> Bool {
        do {
            try png?.write(to: url)
            return true
        } catch {
            print(error)
            return false
        }
        
    }
}

func getDefaults(name: String) -> Dictionary<String, Any> {
    var dictionary: [String: Any] = [:]
    if let url = Bundle.main.url(forResource: name, withExtension: "plist") {
        do {
            let data = try Data(contentsOf: url)
            dictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String : Any]
        } catch {
            print("No Plist Found")
        }
    }
    return dictionary
}
