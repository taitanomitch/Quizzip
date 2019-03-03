//
//  ViewController.swift
//  Quizzip
//
//  Created by Mitchell Taitano on 1/5/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import UIKit

class CountryFlagQuizViewController: UIViewController {

    @IBOutlet weak var AnswerButtonOne: UIButton!
    @IBOutlet weak var AnswerButtonTwo: UIButton!
    @IBOutlet weak var AnswerButtonThree: UIButton!
    @IBOutlet weak var AnswerButtonFour: UIButton!
    @IBOutlet weak var CountryAnswerImageView: UIImageView!
    @IBOutlet weak var DimmingView: UIView!
    @IBOutlet weak var DimmingBackgroundView: UIView!
    @IBOutlet weak var AnswerResultView: UIView!
    @IBOutlet weak var CorrectLabel: UILabel!
    @IBOutlet weak var CorrectAnswerLabel: UILabel!
    @IBOutlet weak var QuestionNumberLabel: UILabel!
    @IBOutlet weak var CorrectIncorrectLabel: UILabel!
    
    @IBOutlet weak var FinalScoreView: UIView!
    @IBOutlet weak var FinalScoreBackgroundView: UIView!
    @IBOutlet weak var FinalScoreBoxView: UIView!
    @IBOutlet weak var FinalScoreLabel: UILabel!
    
    var answerArray: [Int] = []
    
    var correct: Bool = false
    var numberOfCountries: UInt32 = 197
    var correctAnswerButton: Int = -1
    var correctAnswer: Int = -1
    var correctAnswerName: String = ""
    var otherAnswerOne: Int = -1
    var otherAnswerTwo: Int = -1
    var otherAnswerThree: Int = -1
    var numberOfQuestions: Int = 20
    var questionsAnswered: Int = 0
    var answersCorrect: Int = 0
    var answersIncorrect: Int = 0
    
    private var hideDimmerTimer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNumberOfCountries()
        setUpDimmingViewUI()
        setUpFinalScoreUI()
        setUpButtonsUI()
        setUpLabels()
        randomizeAnswerButton()
        selectAnswers()
        setAnswers()
    }
    
    func setUpLabels() {
        QuestionNumberLabel.text = "0/" + String(numberOfQuestions)
        CorrectIncorrectLabel.text = "0:0"
    }
    
    func setUpDimmingViewUI() {
        AnswerResultView.layer.cornerRadius = 5.0
        AnswerResultView.layer.masksToBounds = true
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
    
    func getNumberOfCountries() {
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "CountriesPropertyList", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDict {
            numberOfCountries = UInt32(dict.count)
        }
    }
    
    func selectAnswers() {
        for _ in 0..<numberOfQuestions {
            var myDict: NSDictionary?
            if let path = Bundle.main.path(forResource: "CountriesPropertyList", ofType: "plist") {
                myDict = NSDictionary(contentsOfFile: path)
            }
            if let dict = myDict {
                var answerSelected = false
                while(!answerSelected) {
                    let randomCountry = String(arc4random_uniform(UInt32(dict.count) + 1))
                    let nextAnswer = Int(randomCountry)!
                    if(!answerArray.contains(nextAnswer)) {
                        answerArray.append(nextAnswer)
                        answerSelected = true
                    }
                }
            }
            
        }
    }
    
    func setAnswers() {
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "CountriesPropertyList", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDict {
            correctAnswer = answerArray[questionsAnswered]
            getOtherAnswers()
            var selectedCountry = String(describing: dict.value(forKey: String(correctAnswer))!)
            correctAnswerName = selectedCountry
            
            switch  correctAnswerButton {
            case 1:
                AnswerButtonOne.setTitle(selectedCountry, for: UIControlState.normal)
                selectedCountry = String(describing: dict.value(forKey: String(otherAnswerOne))!)
                AnswerButtonTwo.setTitle(selectedCountry, for: UIControlState.normal)
                selectedCountry = String(describing: dict.value(forKey: String(otherAnswerTwo))!)
                AnswerButtonThree.setTitle(selectedCountry, for: UIControlState.normal)
                selectedCountry = String(describing: dict.value(forKey: String(otherAnswerThree))!)
                AnswerButtonFour.setTitle(selectedCountry, for: UIControlState.normal)
            case 2:
                AnswerButtonTwo.setTitle(selectedCountry, for: UIControlState.normal)
                selectedCountry = String(describing: dict.value(forKey: String(otherAnswerOne))!)
                AnswerButtonOne.setTitle(selectedCountry, for: UIControlState.normal)
                selectedCountry = String(describing: dict.value(forKey: String(otherAnswerTwo))!)
                AnswerButtonThree.setTitle(selectedCountry, for: UIControlState.normal)
                selectedCountry = String(describing: dict.value(forKey: String(otherAnswerThree))!)
                AnswerButtonFour.setTitle(selectedCountry, for: UIControlState.normal)
            case 3:
                AnswerButtonThree.setTitle(selectedCountry, for: UIControlState.normal)
                selectedCountry = String(describing: dict.value(forKey: String(otherAnswerOne))!)
                AnswerButtonOne.setTitle(selectedCountry, for: UIControlState.normal)
                selectedCountry = String(describing: dict.value(forKey: String(otherAnswerTwo))!)
                AnswerButtonTwo.setTitle(selectedCountry, for: UIControlState.normal)
                selectedCountry = String(describing: dict.value(forKey: String(otherAnswerThree))!)
                AnswerButtonFour.setTitle(selectedCountry, for: UIControlState.normal)
            case 4:
                AnswerButtonFour.setTitle(selectedCountry, for: UIControlState.normal)
                selectedCountry = String(describing: dict.value(forKey: String(otherAnswerOne))!)
                AnswerButtonOne.setTitle(selectedCountry, for: UIControlState.normal)
                selectedCountry = String(describing: dict.value(forKey: String(otherAnswerTwo))!)
                AnswerButtonThree.setTitle(selectedCountry, for: UIControlState.normal)
                selectedCountry = String(describing: dict.value(forKey: String(otherAnswerThree))!)
                AnswerButtonTwo.setTitle(selectedCountry, for: UIControlState.normal)
            default:
                break
            }

            CountryAnswerImageView.image = UIImage(named: correctAnswerName)
        }
    }
    
    func randomizeAnswerButton() {
        correctAnswerButton = Int(arc4random_uniform(4)) + 1
    }

    func getOtherAnswers() {
        var randomNumber = Int(arc4random_uniform(numberOfCountries)) + 1
        var gettingAnswerOne = true
        while(gettingAnswerOne) {
            if(randomNumber != correctAnswer) {
                otherAnswerOne = randomNumber
                gettingAnswerOne = false
            } else {
                randomNumber = Int(arc4random_uniform(numberOfCountries)) + 1
            }
        }
        var gettingAnswerTwo = true
        randomNumber = Int(arc4random_uniform(numberOfCountries)) + 1
        while(gettingAnswerTwo) {
            if(randomNumber != correctAnswer && randomNumber != otherAnswerOne) {
                otherAnswerTwo = randomNumber
                gettingAnswerTwo = false
            } else {
                randomNumber = Int(arc4random_uniform(numberOfCountries)) + 1
            }
        }
        var gettingAnswerThree = true
        randomNumber = Int(arc4random_uniform(numberOfCountries)) + 1
        while(gettingAnswerThree) {
            if(randomNumber != correctAnswer && randomNumber != otherAnswerOne && randomNumber != otherAnswerTwo) {
                otherAnswerThree = randomNumber
                gettingAnswerThree = false
            } else {
                randomNumber = Int(arc4random_uniform(numberOfCountries)) + 1
            }
        }
    }
    
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

