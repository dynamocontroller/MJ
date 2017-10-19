//
//  ScoreVC.swift
//  MJ
//
//  Created by Nagayama Ryo on 2016/12/09.
//  Copyright © 2016年 Nagayama Ryo. All rights reserved.
//

import Foundation
import UIKit

/**
 
 tag
 0...	自家
 1...	下家
 2...	対面
 3...	上家
 */
class ScoreTableVC: UIViewController, UITextFieldDelegate, ChangeNameVCDelegate {
    
    @IBOutlet var differenceLabels: [UILabel]!
    @IBOutlet var baseViews: [UIView]!

    @IBOutlet weak var zityaNameLabel: UILabel!
    @IBOutlet weak var kamityaNameLabel: UILabel!
    @IBOutlet weak var toimenNameLabel: UILabel!
    @IBOutlet weak var shimotyaNameLabel: UILabel!
    
    @IBOutlet weak var zityaScoreField: UITextField!
    @IBOutlet weak var kamityaScoreField: UITextField!
    @IBOutlet weak var toimenScoreField: UITextField!
    @IBOutlet weak var shimotyaScoreField: UITextField!
    
    private var nameLabels: [UILabel] {
        var ret = [UILabel]()
        	ret.append(self.zityaNameLabel)
        	ret.append(self.kamityaNameLabel)
        	ret.append(self.toimenNameLabel)
        	ret.append(self.shimotyaNameLabel)
        return ret
    }
    
    private var scoreFields: [UITextField] {
        var ret = [UITextField]()
        	ret.append(self.zityaScoreField)
        	ret.append(self.kamityaScoreField)
        	ret.append(self.toimenScoreField)
        	ret.append(self.shimotyaScoreField)
        return ret
    }
    
    @IBOutlet weak var changeNameButton: UIButton!
    
    // MARK: -
    
    private var names: [String?] = {
        var ret = [String?]()
        ret.append(UserDefaults.zityaName)
        ret.append(UserDefaults.kamityaName)
        ret.append(UserDefaults.toimenName)
        ret.append(UserDefaults.shimotyaName)
        return ret
    }()
    
    private var scores: [Int] = {
        var ret = [Int]()
        ret.append(UserDefaults.zityaScore)
        ret.append(UserDefaults.kamityaScore)
        ret.append(UserDefaults.toimenScore)
        ret.append(UserDefaults.shimotyaScore)
        return ret
    }()
    
    // 自家のものはない
    private var diffLabels: [UILabel?] {
        var ret = [UILabel?]()
        // 自家のものはないため[0]にはnilを代入
        ret.append(nil)
        
        for i in 1...3 {
            for label in self.differenceLabels {
                if label.tag == i {
                    ret.append(label)
                    break
                }
            }
        }
        return ret
    }
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scoreFields.forEach({ scoreField in
            scoreField.delegate = self
            scoreField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        })
        
        self.baseViews.forEach({ view in
            view.layer.masksToBounds = false
            view.layer.shadowOpacity = 0.2
            view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            view.layer.cornerRadius = 5.0
        })
    
        self.updateUI()
    }
    
    private func updateUI() {
        self.zityaNameLabel.text		= self.names[0]
        self.kamityaNameLabel.text		= self.names[1]
        self.toimenNameLabel.text		= self.names[2]
        self.shimotyaNameLabel.text		= self.names[3]
        
        self.zityaScoreField.text		= String(self.scores[0])
        self.kamityaScoreField.text		= String(self.scores[1])
        self.toimenScoreField.text		= String(self.scores[2])
        self.shimotyaScoreField.text	= String(self.scores[3])
        
        // 点数の計算と表示
        let zityaScore = self.scores[0]
        for (i, otherScore) in self.scores.enumerated() {
            // ループ一度目は自家と自家の比較なのでcontinue
            guard i != 0 else {
                continue
            }
            // i = 0のとき以外はnilになり得ないが一応
            guard let diffLabel = self.diffLabels[i] else {
                continue
            }
            
            let diff = zityaScore - otherScore
            if diff > 0 {
                diffLabel.textColor = UIColor.green
                diffLabel.text = "+\(diff)"
            } else if diff < 0 {
                diffLabel.textColor = UIColor.red
                diffLabel.text = "\(diff)"
            } else {
                diffLabel.textColor = UIColor.black
                diffLabel.text = "-"
            }
        }
    }

    private func hideKeyboard() {
        self.scoreFields.forEach({ scoreField in
            if scoreField.isFirstResponder {
                scoreField.resignFirstResponder()
                return
            }
        })
    }
    
    private func saveCurrentName() {
        let names = self.names
        UserDefaults.zityaName		= names[0]
        UserDefaults.kamityaName	= names[1]
        UserDefaults.toimenName		= names[2]
        UserDefaults.shimotyaName	= names[3]
    }
    
    private func saveCurrentScore() {
        let scores = self.scores
        UserDefaults.zityaScore		= scores[0]
        UserDefaults.kamityaScore	= scores[1]
        UserDefaults.toimenScore	= scores[2]
        UserDefaults.shimotyaScore	= scores[3]
    }
    
    // MARK: - Action
    
    // いらない??再計算が必要なタイミングがなければ決していい
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        self.hideKeyboard()
        self.updateUI()
    }
    
    @IBAction func rotateButtonTapped(_ sender: UIButton) {
        self.hideKeyboard()
        
        do {
            let temp = self.names[3]
            self.names[3] = self.names[2]
            self.names[2] = self.names[1]
            self.names[1] = self.names[0]
            self.names[0] = temp
        }
        
        do {
            let temp = self.scores[3]
            self.scores[3] = self.scores[2]
            self.scores[2] = self.scores[1]
            self.scores[1] = self.scores[0]
            self.scores[0] = temp
        }
        
        self.saveCurrentName()
        self.saveCurrentScore()
        
        self.updateUI()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        self.hideKeyboard()
        
        self.scores = self.scores.map({ _ in 0 })
        self.saveCurrentScore()
        
        self.updateUI()
    }
    
    @IBAction func changeNameButtonTapped(_ sender: UIButton) {
        self.hideKeyboard()
        
        let changeNameVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "changeNameVC") as! ChangeNameVC
        changeNameVC.delegate = self
     
        self.present(changeNameVC, animated: true, completion: nil)
    }
    
    
    
    @IBAction func adjustScoreButtonTapped(_ sender: UIButton) {
        //
    }
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.hideKeyboard()
    }
    
    // MARK: - UITextFieldDelegate
    
    // 5桁以上は入力不可
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count >= 6 {
            textField.text = String(text.dropLast())
        }
    }
    
    // 現状number padにはreturnキーがないため呼ばれることはない
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // first responderを切るためのメソッド
        
        textField.resignFirstResponder()
        return true
    }
    
    // first respoderが消えたときに呼ばれる
    func textFieldDidEndEditing(_ textField: UITextField) {
        let tag = textField.tag
        
        // nil, 空文字, 数字以外を含む
        // のどれかに当てはまる場合、scoreを0にする
        if let text = textField.text, text != "", text.containsOnlyNumber {
            self.scores[tag] = Int(text) ?? 0
        } else {
            self.scores[tag] = 0
        }
    
        self.saveCurrentScore()
        
        self.updateUI()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    // MARK: - ChangeNameVCDelegate
    
    func didChangeName(_ names: [String?]) {
        self.names = names
        self.saveCurrentName()
        
        self.updateUI()
    }
    
}
