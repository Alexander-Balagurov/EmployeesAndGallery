//
//  PersistentContainer.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 01.08.2021.
//

import CoreData

class PersistentContainer: NSPersistentContainer {

    init() {
        guard let model: NSManagedObjectModel = NSManagedObjectModel.mergedModel(from: nil) else {
            fatalError("Can't load managed object models from bundle")
        }
        super.init(name: "Model", managedObjectModel: model)

        loadStore()

        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSOverwriteMergePolicy
    }

    func clearPersistentStore() {

        let allCategoriesRequest: NSFetchRequest<NSFetchRequestResult> = .init(
            entityName: String(describing: Category.self)
        )

        let batchDeleteCategories = NSBatchDeleteRequest(fetchRequest: allCategoriesRequest)

        do {
            try viewContext.execute(batchDeleteCategories)
        } catch let error {
            fatalError("Unable to delete all objects. Error: \(error.localizedDescription)")
        }
    }

    func newChildOfViewContext() -> NSManagedObjectContext {

        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = viewContext
        context.automaticallyMergesChangesFromParent = true

        return context
    }

    func saveChanges() {

        viewContext.saveChangesIfNeed()
    }
}

fileprivate extension PersistentContainer {

    func loadStore() {

        loadPersistentStores(completionHandler: { (_, error) in

            if let error: NSError = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

extension NSManagedObjectContext {

    func saveChangesIfNeed() {
        guard hasChanges else { return }

        do {
            try save()
        } catch let error {
            fatalError("Unable to save with error: \(error.localizedDescription)")
        }
    }
}
