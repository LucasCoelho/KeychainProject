//
//  HttpMethod.swift
//  KeychainProject
//
//  Created by Lucas Coelho on 8/13/16.
//  Copyright © 2016 Lucas Coelho. All rights reserved.
//

enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
    
    func map<B>(f: (Body) -> B) -> HttpMethod<B> {
        switch self {
        case .get:
            return .get
        case .post(let body):
            return .post(f(body))
        }
    }
}