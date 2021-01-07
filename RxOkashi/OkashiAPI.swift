//
//  OkashiAPI.swift
//  RxOkashi
//
//  Created by Newton on 2020/12/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol OkashiAPI {
    func search(from word: String) -> Observable<[OkashiPage]>
}

class OkashiDefaultAPI: OkashiAPI {
    
    private let host = URL(string: "https://sysbird.jp")!
    private let path = "/toriko/api/"
    
    private let URLSession: Foundation.URLSession
    
    init(URLSession: Foundation.URLSession){
        self.URLSession = URLSession
    }
    
    func search(from word: String) -> Observable<[OkashiPage]> {
        var components = URLComponents(url: host, resolvingAgainstBaseURL: false)!
        components.path = path
        
        let items = [
            URLQueryItem(name: "apikey", value: "guest"),
            URLQueryItem(name: "keyword", value: word),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "max", value: "10")
        ]
        
        components.queryItems = items
        
        let request = URLRequest(url: components.url!)
        return URLSession.rx.response(request: request)
            .map { pair in
                do {
                    let response = try JSONDecoder().decode(OkashiSearchResponse.self, from: pair.data)
                    return response.item
                } catch {
                    throw error
                }
            }
    }
    
}
