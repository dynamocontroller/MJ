//
//  NSObject.swift
//  MJ
//
//  Created by Nagayama Ryo on 2017/10/20.
//  Copyright © 2017年 Nagayama Ryo. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
    
    public var className: String {
        return type(of: self).className
    }
    
}
