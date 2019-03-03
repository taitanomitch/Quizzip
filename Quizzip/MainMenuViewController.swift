//
//  MainMenuViewController.swift
//  Quizzip
//
//  Created by Mitchell Taitano on 3/25/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import UIKit
//import MediaPlayer
//import SpriteKit

class MainMenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - IBOutlets Variables
    @IBOutlet weak var BeginButton: UIButton!
    @IBOutlet weak var StudyButton: UIButton!
    @IBOutlet weak var QuizOptionsCollectionView: UICollectionView!
    
    // MARK: - General Variables
    var optionIsSelected: Bool = false
    var numberOfQuizes: Int = 2
    var selectedIndex: IndexPath?
    
    // MARK: - Loading Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTopButtons()
        QuizOptionsCollectionView.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuizOptionsCollectionView.setNeedsLayout()
    }

    // MARK: - Setup Functions
    func setupTopButtons() {
        BeginButton.layer.cornerRadius = 4.0
        BeginButton.layer.masksToBounds = true
        StudyButton.layer.cornerRadius = 4.0
        StudyButton.layer.masksToBounds = true
        setColorForTopButtons()
    }
    
    func setColorForTopButtons() {
        if(optionIsSelected) {
            BeginButton.backgroundColor = MainMenuViewController.hexUIColor(hex: "647DFF")
            BeginButton.setTitleColor(UIColor.white, for: .normal)
            StudyButton.backgroundColor = MainMenuViewController.hexUIColor(hex: "FAFF6E")
            StudyButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            BeginButton.backgroundColor = MainMenuViewController.hexUIColor(hex: "ECEAFF")
            BeginButton.setTitleColor(UIColor.black, for: .normal)
            StudyButton.backgroundColor = MainMenuViewController.hexUIColor(hex: "FFF4CA")
            StudyButton.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    // MARK: - Button Functions
    @IBAction func didPressBegin(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let selectedQuiz = selectedIndex?.item {
            switch selectedQuiz {
            case 0:
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "CountryFlagQuiz") as! CountryFlagQuizViewController
                self.present(newViewController, animated: true) {
                    
                }
            case 1:
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "VocabularyQuiz") as! VocabularyQuizViewController
                self.present(newViewController, animated: true) {
                    
                }
            default:
                return
            }
        }
    }
    
    @IBAction func didPressStudy(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NotecardViewController") as! NotecardViewController
        if let selectedQuiz = selectedIndex?.item {
            switch selectedQuiz {
            case 0:
                newViewController.notecardType = .CountryFlags
            case 1:
                newViewController.notecardType = .Vocabulary
            default:
                return
            }
        }
        newViewController.progressViewWidth = self.view.frame.width - (newViewController.progressViewBufferSpace * 2)
        self.present(newViewController, animated: false) {
            
        }
    }
    
    
    // MARK: - Tableview Functions
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        optionIsSelected = true
        setColorForTopButtons()
        selectedIndex = indexPath
        QuizOptionsCollectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfQuizes
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (QuizOptionsCollectionView.layer.frame.width / 2) - 5
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = QuizOptionsCollectionView.dequeueReusableCell(withReuseIdentifier: "QuizOption", for: indexPath) as! QuizOptionCollectionViewCell
        cell.backgroundColor = UIColor.blue
        switch indexPath.item {
        case 0:
            cell.quizImage = UIImage(named: "FlagQuiz")
        case 1:
            cell.quizImage = UIImage(named: "VocabularyQuiz")
        default:
            cell.quizImage = UIImage(named: "FlagQuiz")
        }
        cell.setUpCell()
        if (indexPath == selectedIndex) {
            cell.selectCell()
        }
        return cell
    }
    
    
    // MARK: - Utility Functions
    static func hexUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
