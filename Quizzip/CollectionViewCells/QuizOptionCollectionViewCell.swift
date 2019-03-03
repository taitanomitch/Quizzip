//
//  QuizOptionCollectionViewCell.swift
//  Quizzip
//
//  Created by Mitchell Taitano on 3/25/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import UIKit

class QuizOptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var OuterView: UIView!
    @IBOutlet weak var InnerView: UIView!
    @IBOutlet weak var QuizImageView: UIImageView!
    var quizImage: UIImage?
    
    func setUpCell() {
        self.backgroundColor = UIColor.clear
        OuterView.backgroundColor = MainMenuViewController.hexUIColor(hex: "000000")
        OuterView.layer.cornerRadius = 5.0
        OuterView.layer.masksToBounds = true
        InnerView.layer.cornerRadius = 5.0
        InnerView.layer.masksToBounds = true
        if let thisImage = quizImage {
            QuizImageView.image = thisImage
        }
    }
    
    func selectCell() {
        OuterView.backgroundColor = MainMenuViewController.hexUIColor(hex: "BAFFD0")
    }
    
    func deselectCell() {
        OuterView.backgroundColor = MainMenuViewController.hexUIColor(hex: "000000")
    }
}
