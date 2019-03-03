//
//  VocabularyQuizViewController.swift
//  Quizzip
//
//  Created by Mitchell Taitano on 9/13/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import UIKit

class VocabularyQuizViewController: UIViewController {
    
    // MARK: - IBOutlet Variables
    @IBOutlet weak var DefinitionLabel: UILabel!
    
    @IBOutlet weak var AnswerButtonOne: UIButton!
    @IBOutlet weak var AnswerButtonTwo: UIButton!
    @IBOutlet weak var AnswerButtonThree: UIButton!
    @IBOutlet weak var AnswerButtonFour: UIButton!
    
    @IBOutlet weak var DimmingView: UIView!
    @IBOutlet weak var DimmingBackgroundView: UIView!
    @IBOutlet weak var AnswerResultsView: UIView!
    @IBOutlet weak var CorrectLabel: UILabel!
    @IBOutlet weak var CorrectAnswerLabel: UILabel!
    
    @IBOutlet weak var QuestionNumberLabel: UILabel!
    @IBOutlet weak var CorrectIncorrectLabel: UILabel!
    
    @IBOutlet weak var FinalScoreView: UIView!
    @IBOutlet weak var FinalScoreBackgroundView: UIView!
    @IBOutlet weak var FinalScoreBoxView: UIView!
    @IBOutlet weak var FinalScoreLabel: UILabel!
    
    // MARK: - Variables
    var numberOfQuestions: Int = 10
    var numberOfWords: UInt32 = 0
    var answerArray: [Int] = []
    
    var correctAnswerButton: Int = -1
    
    var correctAnswerName: String = ""
    var correctAnswer: Int = -1
    var otherAnswerOne: Int = -1
    var otherAnswerTwo: Int = -1
    var otherAnswerThree: Int = -1
    
    var correct: Bool = false
    var questionsAnswered: Int = 0
    var answersCorrect: Int = 0
    var answersIncorrect: Int = 0
    
    // MARK: - Loading Functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpFinalScoreUI()
        setUp()
        randomizeAnswerButton()
        selectAnswers()
        setAnswers()
    }
    
    // MARK: - Setup Functions
    func setUp() {
        setUpLabels()
        setUpDimmingViewUI()
        getNumberOfWords()
        setUpDimmingViewUI()
        setUpFinalScoreUI()
        setUpLabels()
        setUpButtonsUI()
    }
    
    func setUpLabels() {
        QuestionNumberLabel.text = "0/" + String(numberOfQuestions)
        CorrectIncorrectLabel.text = "0:0"
    }
    
    func setUpDimmingViewUI() {
        CorrectAnswerLabel.textColor = UIColor.black
        AnswerResultsView.layer.cornerRadius = 5.0
        AnswerResultsView.layer.masksToBounds = true
        DimmingView.alpha = 0.0
    }
    
    func setUpFinalScoreUI() {
        FinalScoreBoxView.layer.cornerRadius = 5.0
        FinalScoreBoxView.layer.masksToBounds = true
        FinalScoreView.alpha = 0.0
        FinalScoreBackgroundView.backgroundColor = UIColor.blue
    }
    
    func setUpButtonsUI() {
        AnswerButtonOne.backgroundColor = UIColor.cyan
        AnswerButtonTwo.backgroundColor = UIColor.cyan
        AnswerButtonThree.backgroundColor = UIColor.cyan
        AnswerButtonFour.backgroundColor = UIColor.cyan
        
        AnswerButtonOne.setTitleColor(UIColor.black, for: .normal)
        AnswerButtonTwo.setTitleColor(UIColor.black, for: .normal)
        AnswerButtonThree.setTitleColor(UIColor.black, for: .normal)
        AnswerButtonFour.setTitleColor(UIColor.black, for: .normal)
    }
    
    
    func getNumberOfWords() {
        var myArr: NSArray?
        if let path = Bundle.main.path(forResource: "words", ofType: "plist") {
            myArr = NSArray(contentsOfFile: path)
        }
        if let arr = myArr {
            numberOfWords = UInt32(arr.count)
        }
    }
    
    
    
    // MARK: - Dimming View Functions
    func showDimmingView() {
        if(correct) {
            CorrectLabel.text = "Correct!"
            CorrectLabel.textColor = UIColor.green
            DimmingBackgroundView.backgroundColor = UIColor.green
        } else {
            CorrectLabel.text = "Incorrect."
            CorrectLabel.textColor = UIColor.red
            DimmingBackgroundView.backgroundColor = UIColor.red
        }
        CorrectAnswerLabel.text = correctAnswerName
        UIView.animate(withDuration: 0.3, animations: {
            self.DimmingView.alpha = 1.0
        }) { (done) in
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.hideDimmingView), userInfo: nil, repeats: false)
        }
    }
    
    @objc func hideDimmingView() {
        var endQuiz = false
        if(self.questionsAnswered == self.numberOfQuestions) {
            endQuiz = true
        } else {
            randomizeAnswerButton()
            setAnswers()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.DimmingView.alpha = 0.0
        }) { (done) in
            self.CorrectLabel.text = ""
            self.CorrectLabel.textColor = UIColor.black
            if(endQuiz) {
                self.showFinalScoreView()
            }
        }
    }
    
    // MARK: - Final Score View Functions
    @objc func showFinalScoreView() {
        FinalScoreLabel.text = "You answered \(answersCorrect) questions correctly!"
        UIView.animate(withDuration: 0.3, animations: {
            self.FinalScoreView.alpha = 1.0
        }) { (done) in
            Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.hideFinalScoreView), userInfo: nil, repeats: false)
        }
    }
    
    @objc func hideFinalScoreView() {
        self.dismiss(animated: true, completion: {
            
        })
    }
    
    
    // MARK: - Answer Selection Functions
    func selectAnswers() {
        for _ in 0..<numberOfQuestions {
            var myArr: NSArray?
            if let path = Bundle.main.path(forResource: "words", ofType: "plist") {
                myArr = NSArray(contentsOfFile: path)
            }
            if let arr = myArr {
                var answerSelected = false
                while(!answerSelected) {
                    let randomWord = String(arc4random_uniform(UInt32(arr.count)))
                    let nextAnswer = Int(randomWord)!
                    if(!answerArray.contains(nextAnswer)) {
                        answerArray.append(nextAnswer)
                        answerSelected = true
                    }
                }
            }
        }
    }
    
    func getOtherAnswers() {
        var randomNumber = Int(arc4random_uniform(numberOfWords))
        var gettingAnswerOne = true
        while(gettingAnswerOne) {
            if(randomNumber != correctAnswer) {
                otherAnswerOne = randomNumber
                gettingAnswerOne = false
            } else {
                randomNumber = Int(arc4random_uniform(numberOfWords))
            }
        }
        var gettingAnswerTwo = true
        randomNumber = Int(arc4random_uniform(numberOfWords))
        while(gettingAnswerTwo) {
            if(randomNumber != correctAnswer && randomNumber != otherAnswerOne) {
                otherAnswerTwo = randomNumber
                gettingAnswerTwo = false
            } else {
                randomNumber = Int(arc4random_uniform(numberOfWords))
            }
        }
        var gettingAnswerThree = true
        randomNumber = Int(arc4random_uniform(numberOfWords))
        while(gettingAnswerThree) {
            if(randomNumber != correctAnswer && randomNumber != otherAnswerOne && randomNumber != otherAnswerTwo) {
                otherAnswerThree = randomNumber
                gettingAnswerThree = false
            } else {
                randomNumber = Int(arc4random_uniform(numberOfWords))
            }
        }
    }
    
    // MARK: - Answer Button Functions
    func randomizeAnswerButton() {
        correctAnswerButton = Int(arc4random_uniform(4)) + 1
    }
    
    func setAnswers() {
        var myArr: NSArray?
        if let path = Bundle.main.path(forResource: "words", ofType: "plist") {
            myArr = NSArray(contentsOfFile: path)
        }
        if let arr = myArr {
            correctAnswer = answerArray[questionsAnswered]
            getOtherAnswers()
            
            var myDict: NSDictionary
            myDict = arr[correctAnswer] as! NSDictionary
            
            var selectedWord = myDict.value(forKey: "Words")!
            let selectedDefinition = myDict.value(forKey: "Definition")!
            
            var textForAnswer = selectedWord as! String
            correctAnswerName = textForAnswer
            
            DefinitionLabel.text = (selectedDefinition as! String)
            
            switch  correctAnswerButton {
            case 1:
                AnswerButtonOne.setTitle(textForAnswer, for: UIControlState.normal)
                myDict = arr[otherAnswerOne] as! NSDictionary
                selectedWord = myDict.value(forKey: "Words")!
                textForAnswer = selectedWord as! String
                AnswerButtonTwo.setTitle(textForAnswer, for: UIControlState.normal)
                myDict = arr[otherAnswerTwo] as! NSDictionary
                selectedWord = myDict.value(forKey: "Words")!
                textForAnswer = selectedWord as! String
                AnswerButtonThree.setTitle(textForAnswer, for: UIControlState.normal)
                myDict = arr[otherAnswerThree] as! NSDictionary
                selectedWord = myDict.value(forKey: "Words")!
                textForAnswer = selectedWord as! String
                AnswerButtonFour.setTitle(textForAnswer, for: UIControlState.normal)
            case 2:
                AnswerButtonTwo.setTitle(textForAnswer, for: UIControlState.normal)
                myDict = arr[otherAnswerOne] as! NSDictionary
                selectedWord = myDict.value(forKey: "Words")!
                textForAnswer = selectedWord as! String
                AnswerButtonOne.setTitle(textForAnswer, for: UIControlState.normal)
                myDict = arr[otherAnswerTwo] as! NSDictionary
                selectedWord = myDict.value(forKey: "Words")!
                textForAnswer = selectedWord as! String
                AnswerButtonThree.setTitle(textForAnswer, for: UIControlState.normal)
                myDict = arr[otherAnswerThree] as! NSDictionary
                selectedWord = myDict.value(forKey: "Words")!
                textForAnswer = selectedWord as! String
                AnswerButtonFour.setTitle(textForAnswer, for: UIControlState.normal)
            case 3:
                AnswerButtonThree.setTitle(textForAnswer, for: UIControlState.normal)
                myDict = arr[otherAnswerOne] as! NSDictionary
                selectedWord = myDict.value(forKey: "Words")!
                textForAnswer = selectedWord as! String
                AnswerButtonOne.setTitle(textForAnswer, for: UIControlState.normal)
                myDict = arr[otherAnswerTwo] as! NSDictionary
                selectedWord = myDict.value(forKey: "Words")!
                textForAnswer = selectedWord as! String
                AnswerButtonTwo.setTitle(textForAnswer, for: UIControlState.normal)
                myDict = arr[otherAnswerThree] as! NSDictionary
                selectedWord = myDict.value(forKey: "Words")!
                textForAnswer = selectedWord as! String
                AnswerButtonFour.setTitle(textForAnswer, for: UIControlState.normal)
            case 4:
                AnswerButtonFour.setTitle(textForAnswer, for: UIControlState.normal)
                myDict = arr[otherAnswerOne] as! NSDictionary
                selectedWord = myDict.value(forKey: "Words")!
                textForAnswer = selectedWord as! String
                AnswerButtonOne.setTitle(textForAnswer, for: UIControlState.normal)
                myDict = arr[otherAnswerTwo] as! NSDictionary
                selectedWord = myDict.value(forKey: "Words")!
                textForAnswer = selectedWord as! String
                AnswerButtonThree.setTitle(textForAnswer, for: UIControlState.normal)
                myDict = arr[otherAnswerThree] as! NSDictionary
                selectedWord = myDict.value(forKey: "Words")!
                textForAnswer = selectedWord as! String
                AnswerButtonTwo.setTitle(textForAnswer, for: UIControlState.normal)
            default:
                break
            }
        }
    }
    
    @IBAction func clickAnswerButtonOne(_ sender: UIButton) {
        if(correctAnswerButton == 1) {
            correct = true
            answersCorrect = answersCorrect + 1
        } else {
            correct = false
            answersIncorrect = answersIncorrect + 1
        }
        questionsAnswered = questionsAnswered + 1
        QuestionNumberLabel.text = String(questionsAnswered) + "/" + String(numberOfQuestions)
        CorrectIncorrectLabel.text = String(answersCorrect) + ":" + String(answersIncorrect)
        showDimmingView()
    }
    
    @IBAction func clickAnswerButtonTwo(_ sender: UIButton) {
        if(correctAnswerButton == 2) {
            correct = true
            answersCorrect = answersCorrect + 1
        } else {
            correct = false
            answersIncorrect = answersIncorrect + 1
        }
        questionsAnswered = questionsAnswered + 1
        QuestionNumberLabel.text = String(questionsAnswered) + "/" + String(numberOfQuestions)
        CorrectIncorrectLabel.text = String(answersCorrect) + ":" + String(answersIncorrect)
        showDimmingView()
    }
    
    @IBAction func clickAnswerButtonThree(_ sender: UIButton) {
        if(correctAnswerButton == 3) {
            correct = true
            answersCorrect = answersCorrect + 1
        } else {
            correct = false
            answersIncorrect = answersIncorrect + 1
        }
        questionsAnswered = questionsAnswered + 1
        QuestionNumberLabel.text = String(questionsAnswered) + "/" + String(numberOfQuestions)
        CorrectIncorrectLabel.text = String(answersCorrect) + ":" + String(answersIncorrect)
        showDimmingView()
    }
    
    @IBAction func clickAnswerButtonFour(_ sender: UIButton) {
        if(correctAnswerButton == 4) {
            correct = true
            answersCorrect = answersCorrect + 1
        } else {
            correct = false
            answersIncorrect = answersIncorrect + 1
        }
        questionsAnswered = questionsAnswered + 1
        QuestionNumberLabel.text = String(questionsAnswered) + "/" + String(numberOfQuestions)
        CorrectIncorrectLabel.text = String(answersCorrect) + ":" + String(answersIncorrect)
        showDimmingView()
    }
}
