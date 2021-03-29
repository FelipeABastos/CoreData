//
//  DatabaseCharacter.swift
//  RickAndMortyCharacters
//
//  Created by Felipe Bastos on 22/03/21.
//

import UIKit
import CoreData

class DatabaseCharacter {
    
    var entityName = "ModelCharacter"
    
    static var shared = DatabaseCharacter()
    
    private var context: NSManagedObjectContext!

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func setManagedContext() {
        
        // Connect with Database bank to access data.
        
        self.context = self.persistentContainer.viewContext
    }
    
    //-----------------------------------------------------------------------
    //  MARK: - CRUD
    //-----------------------------------------------------------------------
    
    func create(character: Character) -> Bool {
        self.setManagedContext()

        let _ = self.objectToModel(character)
        
        do {
            try context.save()
        }catch{
            print(error)
        }
        
        return false
    }
    
    func getAll() -> [Character] {
        self.setManagedContext()
        
        let fetchRequest = NSFetchRequest<ModelCharacter>(entityName: entityName)
//        fetchRequest.fetchLimit = 10
//        fetchRequest.fetchOffset = 0
        
        do {
            let list = try context.fetch(fetchRequest) as [ModelCharacter]
            
            var array: [Character] = []
            
            for model in list {
                array.append(self.modelToObject(model))
            }
            
            return array
        }catch{
            print(error)
        }
        
        return []
    }
    
    
    //-----------------------------------------------------------------------
    //  MARK: - Parse objects
    //-----------------------------------------------------------------------
    
    private func modelToObject(_ model: ModelCharacter) -> Character {
        
        return Character(id: Int(model.id),
                         name: model.name,
                         status: model.status,
                         species: model.species,
                         type: model.type,
                         gender: model.gender,
                         image: model.image,
                         episode: model.episode,
                         created: model.created)
    }
    
    private func objectToModel(_ object: Character) -> ModelCharacter {
        
        let model = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                        into: context) as! ModelCharacter
        
        model.id = Int16(object.id ?? 0)
        model.name = object.name
        model.status = object.status
        model.species = object.species
        model.type = object.type
        model.gender = object.gender
        model.image = object.image
        model.episode = object.episode
        model.created = object.created
        
        return model
    }
}
