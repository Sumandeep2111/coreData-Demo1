//
//  ViewController.swift
//  coreData Demo
//
//  Created by MacStudent on 2020-01-16.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //first we create an instance of app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Second we need the context. this context is the manager like location manager,audio manager etc.
        let context = appDelegate.persistentContainer.viewContext
        
        // third step - write into context
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newUser.setValue("Suman", forKey: "name")
        newUser.setValue(4166242559, forKey: "phone")
        newUser.setValue("suman@gmail.com", forKey: "email")
        newUser.setValue(24, forKey: "age")
        
        //4th step - save context
        do {
           try context.save()
            print(newUser, "is saved")
        }catch {
            print(error)
        }
        
        //fetch data and load it
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "email = %@", "Suman")
        request.returnsObjectsAsFaults = false
        //we find are data
        do{
            let result = try context.fetch(request)
            if result.count > 0 {
                for res in result  as! [NSManagedObject]{
                    if let name = res.value(forKey: "name"){
                        print(name)
                    }
                    
                }
            }
        }catch {
            print(error)
        }
    }


}

