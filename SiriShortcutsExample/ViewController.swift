//
//  ViewController.swift
//  SiriShortcutsExample
//
//  Created by Sinan Ege on 3.10.2018.
//  Copyright © 2018 Sinan Ege. All rights reserved.
//

import UIKit
import Intents

enum DrinkType: String {
    case water
    case coffee
    case tea
}

internal class ViewController: UIViewController {
    
    let currentDefaults = UserDefaults.standard
    
    // MARK: IBOutlets
    @IBOutlet private weak var buttonWater: UIButton!
    @IBOutlet private weak var buttonCoffee: UIButton!
    @IBOutlet private weak var buttonTea: UIButton!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonWater.setTitle("Glass of Water (\(currentCount(for: .water)))", for: .normal)
        buttonCoffee.setTitle("Cup of Coffee (\(currentCount(for: .coffee)))", for: .normal)
        buttonTea.setTitle("Cup of Tea (\(currentCount(for: .tea)))", for: .normal)
    }
    
    @IBAction private func glassOfWaterButtonTapped(_ sender: Any?) {
        self.increment(for: .water)
        buttonWater.setTitle("Glass of Water (\(currentCount(for: .water)))", for: .normal)
        self.donateUserActivity(with: .water)
    }
    
    @IBAction private func cupOfCoffeeButtonTapped(_ sender: Any?) {
        increment(for: .coffee)
        buttonCoffee.setTitle("Cup of Coffee (\(currentCount(for: .coffee)))", for: .normal)
        self.donateUserActivity(with: .coffee)
    }
    
    @IBAction private func cupOfTeaButtonTapped(_ sender: Any?) {
        increment(for: .tea)
        buttonTea.setTitle("Cup of Tea (\(currentCount(for: .tea)))", for: .normal)
        self.donateUserActivity(with: .tea)
    }
    
    // MARK: Private Utilities
    private func increment(for drink: DrinkType) {
        let updatedValue = self.currentCount(for: drink) + 1
        currentDefaults.set(updatedValue, forKey: drink.rawValue)
    }
    
    private func currentCount(for drink: DrinkType) -> Int {
        return currentDefaults.integer(forKey: drink.rawValue)
    }
    
    // MARK: Public Action
    public func didDrank(_ drink: DrinkType) {
        switch drink {
        case .water:
            self.glassOfWaterButtonTapped(.none)
        case .coffee:
            self.cupOfCoffeeButtonTapped(.none)
        case .tea:
            self.cupOfTeaButtonTapped(.none)
        }
    }

}

// MARK: Donate User Activity due to DrinkType
extension ViewController {
    func donateUserActivity(with type: DrinkType) {
        let activityTypeName = "com.sinanege.SiriExample.drinkCount"
        let activity = NSUserActivity(activityType: activityTypeName)
        activity.title = "I just drank \(type.rawValue)"
        activity.userInfo = ["drinkType" : type.rawValue]
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        activity.suggestedInvocationPhrase = "Drank \(type.rawValue)"
        view.userActivity = activity
        activity.becomeCurrent()
    }
}
