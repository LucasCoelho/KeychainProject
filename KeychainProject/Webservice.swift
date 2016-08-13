//
//  Webservice.swift
//  KeychainProject
//
//  Created by Lucas Coelho on 8/13/16.
//  Copyright © 2016 Lucas Coelho. All rights reserved.
//

import UIKit

final class Webservice {
    func load<A>(resource: Resource<A>, completion: A? -> ()) {
        let request = NSMutableURLRequest(URL: resource.url)
        request.HTTPMethod = resource.method.method
        if case let .post(data) = resource.method {
            request.HTTPBody = data
        }
        NSURLSession.sharedSession().dataTaskWithRequest(request) { data, _, _ in
            completion(data.flatMap(resource.parse))
            }.resume()
    }
}