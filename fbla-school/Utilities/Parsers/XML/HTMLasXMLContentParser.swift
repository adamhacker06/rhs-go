//
//  HTMLasXMLContentParser.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/3/21.
//

import SwiftUI

/// Meant to extract the HTML paragraph contents of the XML  data inputted
class HTMLasXMLContentParser: XMLParser {
    
    var paragraphs: [String] = []
    var textStore = ""
    
    override init(data: Data) {
        super.init(data: data)
        self.delegate = self
    }
}

extension HTMLasXMLContentParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        switch elementName {
        case "p":
            self.textStore = ""
            
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "p":
            paragraphs.append(textStore)
            
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        textStore += string
    }
}
