//
//  ViewController.swift
//  WoTServerStatus
//
//  Created by Wladyslaw Mostowicz on 11/01/2020.
//  Copyright © 2020 Wladyslaw Mostowicz. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var label_numberOfServers: UILabel!
    @IBOutlet weak var label_wotEu1Online: UILabel!
    @IBOutlet weak var label_wotEu2Online: UILabel!
    @IBOutlet weak var label_wotOverallOnline: UILabel!
    
    @IBOutlet weak var label_wotbEuOnline: UILabel!
    @IBOutlet weak var label_wowsEuOnline: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let group = DispatchGroup()
        
        ServersData(group: group)
        group.wait()
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var request = NSFetchRequest<NSFetchRequestResult>(entityName: "ServersCoreData")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print((data.value(forKey: "game") as! String) + ": " + (data.value(forKey: "server") as! String) + " - " + String((data.value(forKey: "players_online") as! Int)))
            }
            label_numberOfServers.text = String(result.count)
            
        } catch {
            
            print("Failed")
        }
        
        request = NSFetchRequest<NSFetchRequestResult>(entityName: "ServersCoreData")
        var predicate = NSPredicate(format: "game = %@", "World of Tanks")
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            var overall: Int = 0
            for data in result as! [NSManagedObject] {
                
                if((data.value(forKey: "server") as! String) == "EU1")
                {
                    label_wotEu1Online.text = String((data.value(forKey: "players_online") as! Int))
                    overall = overall + (data.value(forKey: "players_online") as! Int)
                }
                if((data.value(forKey: "server") as! String) == "EU2")
                {
                    label_wotEu2Online.text = String((data.value(forKey: "players_online") as! Int))
                    overall = overall + (data.value(forKey: "players_online") as! Int)
                }
            }
            label_wotOverallOnline.text = String(overall)
            
        } catch {
            
            print("Failed")
        }
        
        predicate = NSPredicate(format: "game = %@", "World of Tanks Blitz")
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            var overall: Int = 0
            for data in result as! [NSManagedObject] {

                label_wotbEuOnline.text = String((data.value(forKey: "players_online") as! Int))
                    overall = overall + (data.value(forKey: "players_online") as! Int)
                
            }
            
        } catch {
            
            print("Failed")
        }
        
        predicate = NSPredicate(format: "game = %@", "World of Warships")
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            var overall: Int = 0
            for data in result as! [NSManagedObject] {
                
                label_wowsEuOnline.text = String((data.value(forKey: "players_online") as! Int))
                overall = overall + (data.value(forKey: "players_online") as! Int)
                
            }
            
        } catch {
            
            print("Failed")
        }
    }
}

