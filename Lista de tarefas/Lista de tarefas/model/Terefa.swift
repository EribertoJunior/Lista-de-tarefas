//
//  Terefa.swift
//  Lista de tarefas
//
//  Created by aluno on 07/02/19.
//  Copyright © 2019 teste. All rights reserved.
//

import Foundation


class Tarefa: NSObject, NSCoding  {
    var descricao: String
    var latitude: Double
    var longitude: Double
    
    init(descricao: String, latitude: Double, longitude: Double) {
        
        self.descricao = descricao
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let descricao = aDecoder.decodeObject(forKey: "descricao") as? String else {
            return nil
        }
        
        self.init(descricao: descricao, latitude: aDecoder.decodeDouble(forKey: "latitude"), longitude: aDecoder.decodeDouble(forKey: "longitude"))
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(descricao, forKey: "descricao")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
    }
}
