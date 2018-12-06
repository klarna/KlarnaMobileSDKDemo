//
//  Bundle+Extensions.swift
//  KlarnaMobileSDKDemo
//

import Foundation

extension Bundle {

    static var harryHtmlString: String {
        guard let path = main.path(forResource: "harry", ofType: "html") else {
            fatalError("File not found harry.html")
        }

        guard let htmlString = try? String(contentsOfFile: path, encoding: .utf8) else {
            fatalError("Can not convert harry.html into string, file possibly corrupted.")
        }

        return htmlString
    }
}
