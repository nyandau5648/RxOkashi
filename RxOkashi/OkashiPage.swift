//
//  OkashiPage.swift
//  RxOkashi
//
//  Created by Newton on 2020/12/24.
//

import Foundation

struct OkashiSearchResponse: Decodable {
    
    let item: [OkashiPage]
    
}

struct OkashiPage {
    let name: String
    let url: URL
}

extension OkashiPage: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case name 
        case maker
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        let urlString = "https://www.sysbird.jp/webapi/?apikey=guest&format=json&keyword=\(name)"
        let encodeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        self.url = URL(string: encodeUrlString!)!
    }
    
}
