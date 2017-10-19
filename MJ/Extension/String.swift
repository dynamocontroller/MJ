//
//  String.swift
//  MJ
//
//  Created by Nagayama Ryo on 2017/10/18.
//  Copyright © 2017年 Nagayama Ryo. All rights reserved.
//

import Foundation

extension String {
    public var containsOnlyNumber: Bool {
        // [0-9]かどうかを検証
        return self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
