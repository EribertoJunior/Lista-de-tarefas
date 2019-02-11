//
//  MyTableViewCell.swift
//  Lista de tarefas
//
//  Created by aluno on 05/02/19.
//  Copyright © 2019 teste. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var texto: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func excluirCelula(_ sender: UIButton) {
        
    }
}
