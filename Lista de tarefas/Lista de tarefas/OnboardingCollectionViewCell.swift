//
//  OnboardingCollectionViewCell.swift
//  Lista de tarefas
//
//  Created by aluno on 06/02/19.
//  Copyright © 2019 teste. All rights reserved.
//

import UIKit

struct OnboardingCollectionViewCellModel {
    var title: String?
    var description: String?
    var imageName: String?
    
    init(title: String, description: String, imageName: String) {
        self.title = title
        self.description = description
        self.imageName = imageName
    }
}

class OnboardingCollectionViewCell: UICollectionViewCell {
    // MARK: IBOutlets Variables
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var imagemDeFundo: UIImageView!
    
    // MARK: Model Variables
    var model: OnboardingCollectionViewCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populate(model: OnboardingCollectionViewCellModel) {
        self.model = model
        titulo.text = model.title
        descricaoLabel.text = model.description
        
        if let imageName = model.imageName {
            imagemDeFundo.image = UIImage(named: imageName)
        }
    }
}
