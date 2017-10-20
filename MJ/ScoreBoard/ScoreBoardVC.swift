//
//  ScoreBoardVC.swift
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
class ScoreBoardVC: UIViewController, UITextFieldDelegate, ChangeNameVCDelegate {
    
    @IBOutlet var differenceLabels: [UILabel]!
    @IBOutlet var baseViews: [UIView]!

    @IBOutlet weak var zityaNameLabel: UILabel!
    @IBOutlet weak var shimotyaNameLabel: UILabel!
    @IBOutlet weak var toimenNameLabel: UILabel!
    @IBOutlet weak var kamityaNameLabel: UILabel!
    
    @IBOutlet weak var zityaScoreField: UITextField!
    @IBOutlet weak var shimotyaScoreField: UITextField!
    @IBOutlet weak var toimenScoreField: UITextField!
    @IBOutlet weak var kamityaScoreField: UITextField!
    
    private var nameLabels: [UILabel] {
        var ret = [UILabel]()
        ret.append(self.zityaNameLabel)
        ret.append(self.shimotyaNameLabel)
        ret.append(self.toimenNameLabel)
        ret.append(self.kamityaNameLabel)
        return ret
    }
    
    private var scoreFields: [UITextField] {
        var ret = [UITextField]()
        ret.append(self.zityaScoreField)
        ret.append(self.shimotyaScoreField)
        ret.append(self.toimenScoreField)
        ret.append(self.kamityaScoreField)
        return ret
    }
    
    @IBOutlet weak var changeNameButton: UIButton!
    @IBOutlet weak var rotateButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    private var buttons: [UIButton] {
        return [self.changeNameButton, self.rotateButton, self.clearButton]
    }
    
    // MARK: -
    
    private var names: [String?] = {
        var ret = [String?]()
        ret.append(UserDefaults.zityaName)
        ret.append(UserDefaults.shimotyaName)
        ret.append(UserDefaults.toimenName)
        ret.append(UserDefaults.kamityaName)
        return ret
    }()
    
    private var scores: [Int] = {
        var ret = [Int]()
        ret.append(UserDefaults.zityaScore)
        ret.append(UserDefaults.shimotyaScore)
        ret.append(UserDefaults.toimenScore)
        ret.append(UserDefaults.kamityaScore)
        return ret
    }()
    
    // 4人のscoreを高い順に並べ替えたもの(重複を許さず)の要素の中の
    // 自家のscoreのindex + 1を返すことで順位を求めている
    private var zityaRank: Int {
        let zityaScore = self.scores[0]
        
        var scores = self.scores
        var ordered = [Int]()
        
        while let max = scores.max() {
            ordered.append(max)
            while scores.contains(max) {
                scores.remove(at: scores.index(of: max)!)
            }
        }
        
        let rank = ordered.index(of: zityaScore)! + 1
        return rank
    }
    
    // 自家のものは順位表示用として使う
    private var diffLabels: [UILabel] {
        var ret = [UILabel]()
        for i in self.differenceLabels.startIndex..<self.differenceLabels.endIndex {
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
            view.layer.shadowOpacity = 0.4
            view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            view.layer.cornerRadius = 5.0
        })
        
        self.buttons.forEach({ button in
            button.clipsToBounds = false
            button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            button.layer.shadowOpacity = 0.4
        })
    
        self.updateUI()
    }
    
    private func updateUI() {
        self.zityaNameLabel.text		= self.names[0]
        self.shimotyaNameLabel.text     = self.names[1]
        self.toimenNameLabel.text       = self.names[2]
        self.kamityaNameLabel.text      = self.names[3]
        
        self.zityaScoreField.text		= String(self.scores[0])
        self.shimotyaScoreField.text	= String(self.scores[1])
        self.toimenScoreField.text		= String(self.scores[2])
        self.kamityaScoreField.text		= String(self.scores[3])
        
        // 点数の計算と表示
        let zityaScore = self.scores[0]
        for (i, otherScore) in self.scores.enumerated() {
            let diffLabel = self.diffLabels[i]
            
            // i = 0の場合のdiffLavelは自家のものなので順位を設定する
            if i == 0 {
                diffLabel.text = "\(self.zityaRank)位"
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
        UserDefaults.zityaName		= self.names[0]
        UserDefaults.shimotyaName	= self.names[1]
        UserDefaults.toimenName		= self.names[2]
        UserDefaults.kamityaName	= self.names[3]
    }
    
    private func saveCurrentScore() {
        UserDefaults.zityaScore		= self.scores[0]
        UserDefaults.shimotyaScore	= self.scores[1]
        UserDefaults.toimenScore	= self.scores[2]
        UserDefaults.kamityaScore	= self.scores[3]
    }
    
    // MARK: - Action
    
    @IBAction func changeNameButtonTapped(_ sender: UIButton) {
        self.hideKeyboard()
        
        let changeNameVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "changeNameVC") as! ChangeNameVC
        changeNameVC.delegate = self
        
        self.present(changeNameVC, animated: true, completion: nil)
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
