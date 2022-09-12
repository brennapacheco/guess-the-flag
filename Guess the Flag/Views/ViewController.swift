//
//  ViewController.swift
//  Guess the Flag
//
//  Created by Brenna Pacheco da Silva Alves on 09/09/22.
//

import UIKit

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
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
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
        
        title = countries[correctAnswer].uppercased()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        var title: String
        
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

    func setupButtons() {
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        
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
        ])
    }
}
