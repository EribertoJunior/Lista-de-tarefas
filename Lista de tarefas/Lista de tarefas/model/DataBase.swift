//
//  DataBase.swift
//  Lista de tarefas
//
//  Created by aluno on 05/02/19.
//  Copyright © 2019 teste. All rights reserved.
//

import Foundation

class Database {
    
    static let shared = Database()
    
    var storage:Array<Tarefa> = []
    
    var userDefault : UserDefaults = UserDefaults.init()
    var chave: String = "listaTarefas"
    
    private init(){}
    private func save(){
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.storage)
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: chave)
    }
    
    private func recover() {
        if let decoded  = UserDefaults.standard.object(forKey: chave) as? Data {
            self.storage = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Array<Tarefa>
        }
        
        
    }
    
    func insert(add value: Tarefa) {
        self.storage.append(value)
        save()
    }
    
    func delete(add index: Int) {
        
        self.storage.remove(at: index)
        save()
        
    }
    
    func list() -> Array<Tarefa>{
        recover()
        return self.storage
    }
    
    
    
    func edit(index: Int, value: Tarefa) {
        self.storage[index] = value
        save()
    }
    
    static func instance() -> Database {
        return self.shared
    }
}
