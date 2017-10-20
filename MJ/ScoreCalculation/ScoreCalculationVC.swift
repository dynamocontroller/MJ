//
//  ScoreCalculationVC.swift
//  MJ
//
//  Created by Nagayama Ryo on 2016/12/06.
//  Copyright © 2016年 Nagayama Ryo. All rights reserved.
//

import Foundation
import UIKit

class ScoreCalculationVC: UIViewController {

    @IBOutlet weak var parentButton: UIButton!
    @IBOutlet weak var childButton: UIButton!
    
    @IBOutlet weak var fuLabel: UILabel!
    @IBOutlet weak var hanLabel: UILabel!
    @IBOutlet weak var honbaLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    
    // 5飜以上の場合は符の値は関係ないのでhiddenする為に保持する
    @IBOutlet weak var huBaseView: UIView!
    
    // MARK: -

    var role: String = "親"
    var isParent: Bool { return role == "親" }
    
    var hu: Int = 20
    var han: Int = 1
    var honba: Int = 0
    
    private var field = Field()
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()
    }
    
    private func updateUI() {
        // 符の値に関わらず満貫以上（5飜以上）の場合は符のviewを消す
        self.huBaseView.isHidden = self.field.han.isUnconditionallyGreaterThanMangan
        
        // 現在のroleのbuttonのtitleをBoldにする
        if self.field.role.isParent {
            let pointSize = self.parentButton.titleLabel?.font.pointSize ?? 30.0
            self.parentButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: pointSize)
            self.childButton.titleLabel?.font =  UIFont.systemFont(ofSize: pointSize)
        } else {
            let pointSize = self.parentButton.titleLabel?.font.pointSize ?? 30.0
            self.parentButton.titleLabel?.font =  UIFont.systemFont(ofSize: pointSize)
            self.childButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: pointSize)
        }
        
        self.fuLabel.text = "\(self.field.fu.value)符"
        self.hanLabel.text = "\(self.field.han.value)飜"
        self.honbaLabel.text = "\(self.field.honba.value)本場"
        
        // summaryの文字列構成
        let role = self.field.role.rawValue
        let summary = self.field.summary
        let honba = "\(self.field.honba.value)本場"
        self.summaryLabel.text = role + " " + summary + " " + honba
        
        // 得点の表示
        let ron: String
        let tumo: String
        
        if let paymentInRonCase = self.field.paymentInRonCase {
            ron = "\(paymentInRonCase)"
        } else {
            ron = "-"
        }
        
        if let paymentInTumoCase = self.field.paymentInTumoCase {
            if self.field.role.isParent {
                tumo = "\(paymentInTumoCase.child) all"
            } else {
                tumo = "\(paymentInTumoCase.child) : \(paymentInTumoCase.parent!)"
            }
        } else {
            tumo = "-"
        }
        
        self.paymentLabel.text = ron + " (" + tumo + ")"
    }
    
    // MARK: - Action
    
    @IBAction func roleButtonTapped(_ sender: UIButton) {
        self.field.role = (sender.tag == 0 ? .parent : .child)
    
        self.updateUI()
    }
    
    @IBAction func changeHuButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            self.field.fu.up()
        } else {
            self.field.fu.down()
        }
        
        self.updateUI()
    }
    
    @IBAction func changeHanButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            self.field.han.up()
        } else {
            self.field.han.down()
        }
        
        self.updateUI()
    }

    @IBAction func changeHonbaButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            self.field.honba.up()
        } else {
            self.field.honba.down()
        }
        
        self.updateUI()
    }
}
