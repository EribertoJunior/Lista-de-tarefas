//
//  OnboardingViewController.swift
//  Lista de tarefas
//
//  Created by aluno on 06/02/19.
//  Copyright © 2019 teste. All rights reserved.
//

import UIKit

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: IBOutlets Variables
    
    // MARK: Datasource Variables
    var datasource = [
        OnboardingCollectionViewCellModel(title: "Salve suas tarefas", description: "Este app serve para salvar sua tarefas e onde essa tarefa será feita", imageName: "background"),
        OnboardingCollectionViewCellModel(title: "Tenha paciência kkk", description: "Esse app é o rascunho do prototipo do que seria a primeira vercao, entao exercite sua abstracao kk", imageName: "background")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "OnboardingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        collectionView.isPagingEnabled = true
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(gestureApplied))
        gesture.direction = .down
        view.addGestureRecognizer(gesture)
        //        configureButton()
    }
    
    @objc func gestureApplied() {
        dismiss(animated: true, completion: nil)
    }
    
    //    private func configureButton() {
    //        closeButton.layer.cornerRadius = 3
    //        closeButton.layer.masksToBounds = true
    //    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        let row = indexPath.row
        cell.populate(model: datasource[row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
