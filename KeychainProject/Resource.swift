//
//  Resource.swift
//  KeychainProject
//
//  Created by Lucas Coelho on 8/13/16.
//  Copyright © 2016 Lucas Coelho. All rights reserved.
//

import UIKit

struct Resource<A> {
    let url: NSURL
    let method: HttpMethod<NSData>
    let parse: (NSData) -> A?
}

extension Resource {
    init(url: NSURL, method: HttpMethod<AnyObject> = .get, parseJSON: (AnyObject) -> A?) {
        self.url = url
        self.method = method.map { json in
            return try! NSJSONSerialization.dataWithJSONObject(json, options: [])
        }
        self.parse = { data in
            let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
            return json.flatMap(parseJSON)
        }
    }
}
