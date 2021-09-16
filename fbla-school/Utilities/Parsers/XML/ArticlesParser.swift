//
//  ArticlesParser.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/1/21.
//

import Foundation

class ArticlesParser: XMLParser {
    
    var articles: [Article] = []
    
    var currentElement: String = ""
    
    let dateTimeZone = TimeZone(abbreviation: "GMT-6")
    
    lazy var dateFormater: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        df.timeZone = dateTimeZone
        return df
    }()
    
    private var textStore: String = ""
    private var nextArticle: Article? = nil
    
    override init(data: Data) {
        super.init(data: data)
        self.delegate = self
    }
}

extension ArticlesParser: XMLParserDelegate {
    
    // Executes at every tag, if statement only applies if the tag is a opening "item" tag
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        self.currentElement = elementName
        
        switch elementName {
        case "item":
            self.nextArticle = Article()
            
        case "title":
            self.textStore = ""
        
        case "dc:creator":
            self.textStore = ""
            
        case "pubDate":
            self.textStore = ""
        
        case "category":
            self.textStore = ""
            
        case "content:encoded":
            self.textStore = ""
            
        default:
            break
        }
        
    }
    
    // Executes at every tag, if statement only applies if the tag is a closing "item" tag
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "item":
            if let article = nextArticle {
                self.articles.append(article)
            }
            
        case "title":
            nextArticle?.title = textStore
            
        case "dc:creator":
            nextArticle?.author = textStore
            
        case "pubDate":
            nextArticle?.publishedDate = dateFormater.date(from: textStore)!
            
        case "category":
            if GiganteaCategories.allCases.contains(where: { $0.rawValue == textStore } ) {
                nextArticle?.category = textStore
            }
            
        case "content:encoded":
            nextArticle?.htmlContent = textStore
            
        default:
            break
        }
    }
    
    // Parses data
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        textStore += string
    }
    
    // Called when a CDATA block is found
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        
        guard let string = String(data: CDATABlock, encoding: .utf8) else {
            print("CDATA contains non-textual data, ignored")
            return
        }
        
        textStore += string
    }
}

enum GiganteaCategories: String, CaseIterable {
    case covid19 = "Covid-19"
    case sports = "Sports"
    case clubsAndLifestyle = "Clubs & Lifestyles"
    case artsAndEntertainment = "Arts and Entertainment"
    case opinion = "Opinion"
    case photoGallery = "Photo Gallery"
    case government = "Government & Politics"
    case humansOfRedwood = "Humans of Redwood"
}
