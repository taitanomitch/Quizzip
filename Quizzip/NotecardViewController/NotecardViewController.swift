//
//  NotecardViewController.swift
//  Quizzip
//
//  Created by Mitchell Taitano on 11/8/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import UIKit

class NotecardViewController: UIViewController {

    // MARK: - Quiz Types
    enum QuizType {
        case CountryFlags
        case Vocabulary
        case None
    }
    
    // MARK: - IBOutlet Variables
    @IBOutlet weak var NotecardView: UIView!
    @IBOutlet weak var AnswerBackgroundView: UIView!
    @IBOutlet weak var AnswerLabel: UILabel!
    
    @IBOutlet weak var DefinitionBackgroundView: UIView!
    @IBOutlet weak var DefinitionImageView: UIImageView!
    @IBOutlet weak var DefinitionLabel: UILabel!
    
    @IBOutlet weak var ProgressionView: UIView!
    @IBOutlet weak var MarkerViewLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var MarkerViewTrailingSpace: NSLayoutConstraint!
    
    
    
    // MARK: - Variables
    public var notecardType: QuizType = QuizType.None
    var currentNotecard: Int = 0
    var totalNotecards: Int = 0
    var markerWidth: CGFloat = 0
    var progressViewWidth: CGFloat = 0
    var progressViewBufferSpace: CGFloat = 25

    
    
    // MARK: - Loading Functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNoteCard()
        prepareNotecards()
        goToNotecard(notecard: currentNotecard)
        setupProgressionView()
    }
    
    
    // MARK: - Setup Functions
    func setupNoteCard() {
        NotecardView.layer.cornerRadius = 5.0
        NotecardView.layer.masksToBounds = true
        switch notecardType {
            case .CountryFlags:
                DefinitionLabel.alpha = 0.0
                DefinitionImageView.alpha = 1.0
            case .Vocabulary:
                DefinitionLabel.alpha = 1.0
                DefinitionImageView.alpha = 0.0
            case .None:
                break
        }
    }
    
    func setupProgressionView() {
        ProgressionView.layer.borderColor = UIColor.white.cgColor
        ProgressionView.layer.borderWidth = 1.0
        
        markerWidth = (ProgressionView.frame.width / CGFloat(totalNotecards))
//        markerWidth = (progressViewWidth / CGFloat(totalNotecards))

        MarkerViewLeadingSpace.constant = 0
        MarkerViewTrailingSpace.constant = CGFloat(totalNotecards - 1) * markerWidth
    }
    
    func prepareNotecards() {
        switch notecardType {
            case .CountryFlags:
                currentNotecard = 1
                var myDict: NSDictionary?
                if let path = Bundle.main.path(forResource: "CountriesPropertyList", ofType: "plist") {
                    myDict = NSDictionary(contentsOfFile: path)
                }
                if let dict = myDict {
                    totalNotecards = dict.count
                }
            case .Vocabulary:
                var myArr: NSArray?
                if let path = Bundle.main.path(forResource: "words", ofType: "plist") {
                    myArr = NSArray(contentsOfFile: path)
                }
                if let arr = myArr {
                    totalNotecards = arr.count
                }
            case .None:
                break
        }
    }
    
    
    // MARK: - Notecard Functions
    func goToNotecard(notecard: Int) {
        switch notecardType {
            case .CountryFlags:
                var myDict: NSDictionary?
                if let path = Bundle.main.path(forResource: "CountriesPropertyList", ofType: "plist") {
                    myDict = NSDictionary(contentsOfFile: path)
                }
                if let dict = myDict {
                    let correctAnswerName = String(describing: dict.value(forKey: String(notecard))!)
                    AnswerLabel.text = correctAnswerName
                    DefinitionImageView.image = UIImage(named: correctAnswerName)
                }
            case .Vocabulary:
                var myArr: NSArray?
                if let path = Bundle.main.path(forResource: "words", ofType: "plist") {
                    myArr = NSArray(contentsOfFile: path)
                }
                if let arr = myArr {
                    let myDict: NSDictionary = arr[notecard] as! NSDictionary
                    AnswerLabel.text = (myDict.value(forKey: "Words")! as! String)
                    DefinitionLabel.text = (myDict.value(forKey: "Definition")! as! String)
                }
            case .None:
                break
        }
    }
    
    
    // MARK: - Progression View Functions
    func updateProgressionView() {
        var index = CGFloat(currentNotecard)
        if(notecardType == .CountryFlags) {
            index = index - 1
        }

        MarkerViewLeadingSpace.constant = index * markerWidth
        MarkerViewTrailingSpace.constant = (CGFloat(totalNotecards - 1) - index) * markerWidth
        self.view.layoutIfNeeded()
    }
    
    
    // MARK: - Top Button Functions
    @IBAction func pressCloseButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: {
            
        })
    }
    
    
    // MARK: - Note Transition Functions
    @IBAction func pressNextButton(_ sender: UIButton) {
        if(notecardType == .CountryFlags) {
            if(currentNotecard != totalNotecards) {
                currentNotecard = currentNotecard + 1
                goToNotecard(notecard: currentNotecard)
            }
        } else {
            if(currentNotecard != totalNotecards - 1) {
                currentNotecard = currentNotecard + 1
                goToNotecard(notecard: currentNotecard)
            }
        }
        updateProgressionView()
    }
    
    @IBAction func pressNext10Button(_ sender: UIButton) {
        if(notecardType == .CountryFlags) {
            if(currentNotecard <= (totalNotecards - 10)) {
                currentNotecard = currentNotecard + 10
                goToNotecard(notecard: currentNotecard)
            } else {
                currentNotecard = totalNotecards
                goToNotecard(notecard: currentNotecard)
            }
        } else {
            if(currentNotecard <= (totalNotecards - 10) - 1) {
                currentNotecard = currentNotecard + 10
                goToNotecard(notecard: currentNotecard)
            } else {
                currentNotecard = totalNotecards - 1
                goToNotecard(notecard: currentNotecard)
            }
        }
        updateProgressionView()
    }
    
    @IBAction func pressNext25Button(_ sender: UIButton) {
        if(notecardType == .CountryFlags) {
            if(currentNotecard <= (totalNotecards - 25)) {
                currentNotecard = currentNotecard + 25
                goToNotecard(notecard: currentNotecard)
            } else {
                currentNotecard = totalNotecards
                goToNotecard(notecard: currentNotecard)
            }
        } else {
            if(currentNotecard <= (totalNotecards - 25) - 1) {
                currentNotecard = currentNotecard + 25
                goToNotecard(notecard: currentNotecard)
            } else {
                currentNotecard = totalNotecards - 1
                goToNotecard(notecard: currentNotecard)
            }
        }
        updateProgressionView()
    }
    
    
    @IBAction func pressLastButton(_ sender: UIButton) {
        if(notecardType == .CountryFlags) {
            if(currentNotecard != 1) {
                currentNotecard = currentNotecard - 1
                goToNotecard(notecard: currentNotecard)
            }
        } else {
            if(currentNotecard != 0) {
                currentNotecard = currentNotecard - 1
                goToNotecard(notecard: currentNotecard)
            }
        }
        updateProgressionView()
    }
    
    @IBAction func pressLast10Button(_ sender: UIButton) {
        if(notecardType == .CountryFlags) {
            if(currentNotecard >= (1 + 10)) {
                currentNotecard = currentNotecard - 10
                goToNotecard(notecard: currentNotecard)
            } else {
                currentNotecard = 1
                goToNotecard(notecard: currentNotecard)
            }
        } else {
            if(currentNotecard >= (0 + 10)) {
                currentNotecard = currentNotecard - 10
                goToNotecard(notecard: currentNotecard)
            } else {
                currentNotecard = 0
                goToNotecard(notecard: currentNotecard)
            }
        }
        updateProgressionView()
    }
    
    @IBAction func pressLast25Button(_ sender: UIButton) {
        if(notecardType == .CountryFlags) {
            if(currentNotecard >= (1 + 25)) {
                currentNotecard = currentNotecard - 25
                goToNotecard(notecard: currentNotecard)
            } else {
                currentNotecard = 1
                goToNotecard(notecard: currentNotecard)
            }
        } else {
            if(currentNotecard >= (0 + 25)) {
                currentNotecard = currentNotecard - 25
                goToNotecard(notecard: currentNotecard)
            } else {
                currentNotecard = 0
                goToNotecard(notecard: currentNotecard)
            }
        }
        updateProgressionView()
    }
}
