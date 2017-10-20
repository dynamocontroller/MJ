//
//  Score.swift
//  MJ
//
//  Created by Nagayama Ryo on 2017/10/16.
//  Copyright © 2017年 Nagayama Ryo. All rights reserved.
//

import Foundation

struct Field {
    enum Role: String {
        case parent	= "親"
        case child	= "子"
        
        var isParent: Bool {
            return self == .parent
        }
    }
    
    var role = Role.child
    
    var fu		= Fu()
    var han		= Han()
    var honba	= Honba()
    
    // MARK: -
    
    var summary: String {
        return self.han.level(fu: self.fu)
    }
    
    var paymentInRonCase: Int? {
        // 満貫以上の場合は固定値を返す
        switch self.han.value {
        case 3:
            // 3飜の場合は70符以上なら満貫
            if fu.value >= 70 {
                return self.role.isParent ? 12000 : 8000
            }
        case 4:
            // 4飜の場合は40符以上なら満貫
            if fu.value >= 40 {
                return self.role.isParent ? 12000 : 8000
            }
        case 5:
            return self.role.isParent ? 12000 : 8000
        case 6, 7:
            return self.role.isParent ? 18000 : 12000
        case 8, 9, 10:
            return self.role.isParent ? 24000 : 16000
        case 11, 12:
            return self.role.isParent ? 32000 : 24000
        case 13:
            return self.role.isParent ? 48000 : 32000
        default:
            break
        }
        
        // ロン和了があり得ない場合はnilを返す
        switch (self.fu.value, self.han.value) {
        case (20, _), (25, 1):
            return nil
        default:
            break
        }
        
        /**
         計算が必要な場合計算する（本場計算はまだ）
         計算式は以下(十の位切り上げ)
         
         +------------------------------------------+
         |    親の場合：        符 * 6 * 2^(飜数 + 2)	|
         |    子の場合：        符 * 4 * 2^(飜数 + 2)	|
         +------------------------------------------+
         
         */
    
        return self.calcuratePaymentFrom(fu: self.fu.value, han: self.han.value)
    }
    
    // どちらもnilの場合はツモ和了があり得ない場合
    var paymentInTumoCase: (child: Int, parent: Int?)? {
		// まずツモ和了があり得ない場合はnilを返す
        switch (self.fu.value, self.han.value) {
        case (20, 1), (25, 1), (25, 2):
            return  nil
        default:
            break
        }
        
        // ロン和了がありえない場合はnilになっているので計算したものを代入する
        let paymentInRonCase = self.paymentInRonCase ?? self.calcuratePaymentFrom(fu: self.fu.value, han: self.han.value)
        var base = paymentInRonCase / 100

        if self.role.isParent {
            while base % 3 != 0 {
                base += 1
            }
            base *= 100
            
            let child = (base / 3) + (100 * self.honba.value)
            return (child, nil)
        } else {
            while base % 2 != 0 {
                base += 1
            }
            var parentBase	= base
            var childBase	= base / 2
            
            while childBase % 2 != 0 {
                childBase += 1
            }
            parentBase	*= 100
            childBase	*= 100
            
            let child	= (childBase / 2)	+ (100 * self.honba.value)
            let parent	= (parentBase / 2)	+ (100 * self.honba.value)
            
            return (child, parent)
        }
    }
    
    private func calcuratePaymentFrom(fu: Int, han: Int) -> Int {
        var payment = Double(fu)
        payment *= (self.role.isParent ? 6 : 4)
        for _ in 0..<(han + 2) {
            payment *= 2
        }
        // 十の位切り上げ
        payment /= 100
        payment = ceil(payment)
        payment *= 100
        
        return Int(payment)
    }
    
}

protocol FieldElement {
	mutating func up()
    mutating func down()
}

/**
 * 符
 */
struct Fu: FieldElement {
    private let lowerLimit = 20
    private let upperLimit = 110
    
    private(set) var value = 30
    
    mutating func up() {
        let next: Int
        switch self.value {
        case self.upperLimit:
            next = self.lowerLimit
        case 20, 25:
            next = self.value + 5
        default:
            next = self.value + 10
        }
        
        self.value = next
    }
    
    mutating func down() {
        let next: Int
        switch self.value {
        case self.lowerLimit:
            next = self.upperLimit
        case 20, 25:
            next = self.value - 5
        default:
            next = self.value - 10
        }
        
        self.value = next
    }
        
}

/**
 * 飜
 */
struct Han: FieldElement {
    private let lowerLimit = 1
    private let upperLimit = 13
    
    private(set) var value = 3
    
    var isUnconditionallyGreaterThanMangan: Bool {
        return self.value >= 5
    }
    
    func level(fu: Fu) -> String {
        switch self.value {
        case 3:
            // 3飜の場合は70符以上なら満貫
            if fu.value >= 70 {
                return "満貫"
            }
        case 4:
            // 4飜の場合は40符以上なら満貫
            if fu.value >= 40 {
                return "満貫"
            }
        case 5:
            return "満貫"
        case 6, 7:
            return "跳満"
        case 8, 9, 10:
            return "倍満"
        case 11, 12:
            return "３倍満"
        case 13:
            return "役満"
        default:
            break
        }
        
        return "\(fu.value)符 \(self.value)飜"
    }
    
    mutating func up() {
        if self.value != self.upperLimit {
            self.value += 1
        } else {
            self.value = self.lowerLimit
            
        }
    }
    
    mutating func down() {
        if self.value != self.lowerLimit {
            self.value -= 1
        } else {
            self.value = self.upperLimit
        }
    }

}


/**
 * 本場
 */
struct Honba: FieldElement {
    private let lowerLimit = 0
    private let upperLimit = 10
    
    private(set) var value = 0
    
    mutating func up() {
        if self.value != self.upperLimit {
            self.value += 1
        } else {
            self.value = self.lowerLimit
        }
    }
    
    mutating func down() {
        if self.value != self.lowerLimit {
            self.value -= 1
        } else {
            self.value = self.upperLimit
        }
    }
}
