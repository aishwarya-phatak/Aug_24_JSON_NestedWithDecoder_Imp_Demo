//
//  APIResponse.swift
//  Aug_24_JSON_NestedWithDecoder_Imp_Demo
//
//  Created by Vishal Jagtap on 07/11/24.
//

import Foundation

struct Book : Decodable{
    var title : String
    var subtitle : String
    var isbn13 : String
    var price : String
    var image : String
    var url : String
}

struct APIResponse : Decodable{
    var error : String
    var total : String
    var books : [Book]
    
    enum APIResponseKeys : CodingKey{
        case error
        case total
        case books
    }
    
    enum BookKeys : CodingKey{
        case title
        case subtitle
        case isbn13
        case price
        case image
        case url
    }
    
    init(from decoder: any Decoder) throws {
      
        let mainContainer = try! decoder.container(keyedBy: APIResponseKeys.self)
        self.error = try! mainContainer.decode(String.self, forKey: .error)
        self.total = try! mainContainer.decode(String.self, forKey: .total)
       
        var booksArray : [Book] = []
        
        var nestedContainer = try! mainContainer.nestedUnkeyedContainer(forKey: .books)
        
        while !nestedContainer.isAtEnd{
            
            let bookContainer = try! nestedContainer.nestedContainer(keyedBy: BookKeys.self)
                let bookTitle = try! bookContainer.decode(String.self, forKey: .title)
                let booksubtitle = try! bookContainer.decode(String.self, forKey: .subtitle)
                let bookisbn13 = try! bookContainer.decode(String.self, forKey: .isbn13)
                let bookPrice = try! bookContainer.decode(String.self, forKey: .price)
                let bookImage = try! bookContainer.decode(String.self, forKey: .image)
                let bookUrl = try! bookContainer.decode(String.self, forKey: .url)
            
            let newBookObject = Book(title: bookTitle,
                                     subtitle: booksubtitle,
                                     isbn13: bookisbn13,
                                     price: bookPrice,
                                     image: bookImage,
                                     url: bookUrl)
            
            booksArray.append(newBookObject)
        }
        self.books = booksArray
    }
}
