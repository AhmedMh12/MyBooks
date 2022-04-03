//
//  Book.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import Foundation
import JSONParsing

public final class Book: JSONParseable {

    let cover : String?
    let isbn : String?
    let price : Int?
    let synopsis : String?
    let title : String?


  /*  enum CodingKeys: String, CodingKey {
        case cover = "cover"
        case isbn = "isbn"
        case price = "price"
        case synopsis = "synopsis"
        case title = "title"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cover = try values.decodeIfPresent(String.self, forKey: .cover)
        isbn = try values.decodeIfPresent(String.self, forKey: .isbn)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        synopsis = try values.decodeIfPresent([String].self, forKey: .synopsis)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }*/
        init(cover: String,
             isbn : String,
             price : Int,
             synopsis : String,
             title : String
             ) {
            self.cover = cover
            self.isbn = isbn
            self.price = price
            self.synopsis = synopsis
            self.title = title
         
        }
        
        public static func parse(_ json: JSON) throws -> Book {
            let synopsis = json["synopsis"].first
            return try Book(cover: json["cover"]^,
                            isbn: json["isbn"]^,
                            price: json["price"]^,
                            synopsis: (JSON(rawValue: synopsis!) ?? "").rawValue as! String ,
                            title: json["title"]^)
        }

}
