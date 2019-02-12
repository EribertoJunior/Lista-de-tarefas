//
//  ViewController.swift
//  Lista de tarefas
//
//  Created by aluno on 05/02/19.
//  Copyright © 2019 teste. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var onboardingViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var userDefaut =  UserDefaults.init()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        if(!UserDefaults.init().bool(forKey: "olhou")){
            if let viewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController() as? OnboardingViewController {
                present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
       
        if newCollection.verticalSizeClass == .compact {
            onboardingViewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController()
            present(onboardingViewController!, animated: true, completion: nil)
        } else {
            onboardingViewController?.dismiss(animated: true, completion: nil)
        }
    }

}

