//
//  ViewController.swift
//  Guess the Flag
//
//  Created by Brenna Pacheco da Silva Alves on 09/09/22.
//

import UIKit
import SwiftConfettiView

class ViewController: UIViewController {

    private lazy var button1: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.imageView?.contentMode = .scaleAspectFit
        element.accessibilityIdentifier = "button1"
        element.imageView?.layer.borderWidth = 1
        element.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        element.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return element
   }()

    private lazy var button2: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.imageView?.contentMode = .scaleAspectFit
        element.accessibilityIdentifier = "button2"
        element.imageView?.layer.borderWidth = 1
        element.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        element.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        element.tag = 1
        return element
   }()
    
    private lazy var button3: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.imageView?.contentMode = .scaleAspectFit
        element.accessibilityIdentifier = "button3"
        element.imageView?.layer.borderWidth = 1
        element.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        element.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        element.tag = 2
        return element
    }()
    
    private lazy var finalButton: UIButton = {
            let element = UIButton()
            element.translatesAutoresizingMaskIntoConstraints = false
            element.imageView?.contentMode = .scaleAspectFit
            element.accessibilityIdentifier = "finalButton"
            element.layer.masksToBounds = true
            element.backgroundColor = UIColor(named: "finalButton")
            element.tintColor = UIColor.white
            element.setTitle("Play again?", for: .normal)
            element.layer.cornerRadius = 20
            element.addTarget(self, action: #selector(finalAction), for: .touchUpInside)
            element.isHidden = true
            return element
       }()
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var scoreTitle = " | Score: "
    var questionsAsked = 0
    var confettiView = SwiftConfettiView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        setupButtons()
        askQuestion()
    }
    
    func askQuestion(_ sender: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + scoreTitle + String(score)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        var title: String
        questionsAsked += 1

        if questionsAsked == 10 {
            title = "You answered 10 questions"
            
            let dialogMessage = UIAlertController(title: title, message: "Your final score is \(score)", preferredStyle: .alert)
            
            let finishGame = UIAlertAction(title: "Quit", style: .default, handler: didFinishGame)
            
            dialogMessage.addAction(finishGame)
            
            present(dialogMessage, animated: true, completion: nil)
            
            showConfetti()
            
        } else {
            
            if sender.tag == correctAnswer {
                title = "That's correct!"
                score += 1
            } else {
                title = "Ops! That's wrong."
                score -= 1
            }
            
            let dialogMessage = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Continue", style: .default, handler: askQuestion)
            
            dialogMessage.addAction(ok)
            
            present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    func didFinishGame(_ sender: UIAlertAction! = nil) {
        removeConfetti()
        removeButtons()
        showFinalScreen()
    }
    
    @objc func finalAction() {
        finalButton.isHidden = true
        navigationController?.navigationBar.isHidden = false
        score = 0
        questionsAsked = 0
        viewDidLoad()
    }
    
    func removeButtons() {
        button1.removeFromSuperview()
        button2.removeFromSuperview()
        button3.removeFromSuperview()
    }

    func showFinalScreen() {
        finalButton.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }

    func showConfetti() {
        self.confettiView = SwiftConfettiView(frame: self.view.bounds)
        self.view.addSubview(confettiView)

        confettiView.type = .confetti
        confettiView.colors = [UIColor.purple, UIColor.orange, UIColor.black]
        confettiView.startConfetti()
    }

    func removeConfetti() {
        self.confettiView.stopConfetti()
        self.confettiView.removeFromSuperview()
    }
    
    func setupButtons() {
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(finalButton)
        
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            button1.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            button1.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button1.heightAnchor.constraint(equalToConstant: 100),
            button1.widthAnchor.constraint(equalToConstant: 200),
            
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 32),
            button2.leadingAnchor.constraint(equalTo: button1.leadingAnchor),
            button2.trailingAnchor.constraint(equalTo: button1.trailingAnchor),
            button2.heightAnchor.constraint(equalToConstant: 100),
            button2.widthAnchor.constraint(equalToConstant: 200),
            
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 32),
            button3.leadingAnchor.constraint(equalTo: button1.leadingAnchor),
            button3.trailingAnchor.constraint(equalTo: button1.trailingAnchor),
            button3.heightAnchor.constraint(equalToConstant: 100),
            button3.widthAnchor.constraint(equalToConstant: 200),
            
            finalButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 228),
            finalButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 72),
            finalButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -72),
            finalButton.heightAnchor.constraint(equalToConstant: 36),
            finalButton.widthAnchor.constraint(equalToConstant: 72),
        ])
    }
}
