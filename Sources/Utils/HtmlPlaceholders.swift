//
//  HtmlPlaceholders.swift
//  BaseProject
//
//  Created by Nicola De Bei on 14/02/23.
//

import Foundation


struct HtmlUtils {
    
    static let licenseName = "license_eula"
    
    struct LicensePlaceholders {
        static let BACKGROUND_COLOR = "{{background_color}}"
        static let COLOR = "{{text_color}}"
        static let FONT_LINK = "{{font_link}}"
    }
    
    static func generateLicenseHtml() -> String {
        let dict = [LicensePlaceholders.BACKGROUND_COLOR: Asset.Colors.backgroundMain.color.toHex(),
                    LicensePlaceholders.COLOR: Asset.Colors.textMain.color.toHex(),
                    LicensePlaceholders.FONT_LINK: "<link\n" + "href\n" + "=\"\n" + "https://fonts.googleapis.com/css2?family=Noto+Sans+Display:wght@300;700&display=swap\"\n" + "rel\n" + "=\"stylesheet\"\n" + "> "
        ]
                
        //Load the base license
        guard let url = Bundle.main.url(forResource: Self.licenseName, withExtension: "html") else { return "" }
        let originalString = try! String.init(contentsOf: url, encoding: .utf8)
        var newHtmlString = originalString
        
        //Replace placeholders with their values
        for (key, value) in dict {
            newHtmlString = newHtmlString.replacingOccurrences(of: key, with: value)
        }
        return newHtmlString
    }
}
