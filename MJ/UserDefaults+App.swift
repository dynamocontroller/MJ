//
//  UserDefaults+App.swift
//  MJ
//
//  Created by Nagayama Ryo on 2017/10/18.
//  Copyright © 2017年 Nagayama Ryo. All rights reserved.
//

import Foundation

extension UserDefaults {
    private class var zityaKey: String {
        return "zitya"
    }
    private class var kamityaKey: String {
        return "kamitya"
    }
    private class var toimenKey: String {
        return "toimen"
    }
    private class var shimotyaKey: String {
        return "shimotya"
    }
    
    private class var nameKey: String {
    	return ".name"
    }
    private static var scoreKey: String {
        return ".score"
    }
    
    // MARK: -
    
    class var zityaName: String? {
        get {
            let key = self.zityaKey + self.nameKey
            return UserDefaults.standard.string(forKey: key)
        }
        set {
            let key = self.zityaKey + self.nameKey
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    class var zityaScore: Int {
        get {
            let key = self.zityaKey + self.scoreKey
            return UserDefaults.standard.integer(forKey: key)
        }
        set {
            let key = self.zityaKey + self.scoreKey
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    // MARK: -
    
    class var kamityaName: String? {
        get {
            let key = self.kamityaKey + self.nameKey
            return UserDefaults.standard.string(forKey: key)
        }
        set {
            let key = self.kamityaKey + self.nameKey
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    class var kamityaScore: Int {
        get {
            let key = self.kamityaKey + self.scoreKey
            return UserDefaults.standard.integer(forKey: key)
        }
        set {
            let key = self.kamityaKey + self.scoreKey
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    // MARK: -
    
    class var toimenName: String? {
        get {
            let key = self.toimenKey + self.nameKey
            return UserDefaults.standard.string(forKey: key)
        }
        set {
            let key = self.toimenKey + self.nameKey
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    class var toimenScore: Int {
        get {
            let key = self.toimenKey + self.scoreKey
            return UserDefaults.standard.integer(forKey: key)
        }
        set {
            let key = self.toimenKey + self.scoreKey
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    // MARK: -
    
    class var shimotyaName: String? {
        get {
            let key = self.shimotyaKey + self.nameKey
            return UserDefaults.standard.string(forKey: key)
        }
        set {
            let key = self.shimotyaKey + self.nameKey
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    class var shimotyaScore: Int {
        get {
            let key = self.shimotyaKey + self.scoreKey
            return UserDefaults.standard.integer(forKey: key)
        }
        set {
            let key = self.shimotyaKey + self.scoreKey
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    
}
