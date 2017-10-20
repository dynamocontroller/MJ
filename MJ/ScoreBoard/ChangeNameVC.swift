//
//  ChangeNameVC.swift
//  MJ
//
//  Created by Nagayama Ryo on 2017/10/18.
//  Copyright © 2017年 Nagayama Ryo. All rights reserved.
//

import Foundation
import UIKit


protocol ChangeNameVCDelegate: class {
    func didChangeName(_ names: [String?])
}

/**
 names[0]...    自家
 names[1]...    下家
 names[2]...    対面
 names[3]...    上家
 */
class ChangeNameVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet var nameTextFields: [UITextField]!
    
    // MARK: -
    
    weak var delegate: ChangeNameVCDelegate?
    
    private var names: [String?] = [String?](repeating: nil, count: 4)

    // MARK: -
    
    static func instantiate() -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className)
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dialogView.clipsToBounds = true
        self.dialogView.layer.cornerRadius = 5.0
        
        for textField in self.nameTextFields {
            textField.delegate = self
        }
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            self.delegate?.didChangeName(self.names)
        }
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.names[textField.tag] = textField.text
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        self.names[tag] = textField.text
        textField.resignFirstResponder()
        
    
        // tagの若い順に並び替え
        var nameFields: [UITextField] = {
            var ret = [UITextField]()
            for (i, nameField) in self.nameTextFields.enumerated() {
                if nameField.tag == i {
                    ret.append(nameField)
                }
            }
            return ret
        }()
        
        // 他に空のtextFieldがある場合はそこにフォーカスを移動
        // 複数ある場合は
        // 現在のtagより大きいtagを持つtextFieldの中で最も若いtagを持つtextFieldへ
        // なければ最も若いtagを持つtextFieldへ
        
        let startIndex = (tag != nameFields.lastIndex ? tag + 1 : nameFields.startIndex)
        let endIndex = tag
        var index = startIndex
        
        var emptyFields = [UITextField]()
        while index != endIndex {
            let field = nameFields[index]
            if field.text == nil || field.text == "" {
                emptyFields.append(nameFields[index])
            }
            index = (index != nameFields.lastIndex ? index + 1 : nameFields.startIndex)
        }
        
        if let first = emptyFields.first {
            first.becomeFirstResponder()
        }
        
        return true
    }
    
}
