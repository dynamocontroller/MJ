//
//  Array.swift
//  MJ
//
//  Created by Nagayama Ryo on 2017/10/19.
//  Copyright © 2017年 Nagayama Ryo. All rights reserved.
//

import Foundation

extension Array {
    
    /**
     Arrayのlast elementを指すindex
     */
    public var lastIndex: Int {
        // empty arrayの場合はendIndexが0なのでそのまま返す
        return self.isEmpty ? self.lastIndex : self.endIndex - 1
    }
    
}
