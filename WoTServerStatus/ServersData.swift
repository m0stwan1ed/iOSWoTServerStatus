//
//  ServersData.swift
//  WoTServerStatus
//
//  Created by Wladyslaw Mostowicz on 12/01/2020.
//  Copyright © 2020 Wladyslaw Mostowicz. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct Wotb: Decodable
{
    let players_online: Int
    let server: String
}

struct Wot: Decodable
{
    let players_online: Int
    let server: String
}
struct Wows: Decodable
{
    let players_online: Int
    let server: String
}

struct Data: Decodable
{
    let wotb: Array<Wotb>
    let wot: Array<Wot>
    let wows: Array<Wows>
}

struct Servers: Decodable {
    let status: String
    let data: Data
}

class ServersData {
    
    init(group: DispatchGroup)
    {
        let jsonURLString = "https://api.worldoftanks.eu/wgn/servers/info/?application_id=146bc6b8d619f5030ed02cdb5ce759b4"
        guard let url = URL(string: jsonURLString) else { return }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        group.enter()
        
        let task = session.dataTask(with: url)
        {
            (data, response, err) in
            guard let data = data else { return }
            
            do
            {
                let serverStats = try JSONDecoder().decode(Servers.self, from: data)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "ServersCoreData", in: context)
                
                
                for data in serverStats.data.wot
                {
                    let newServer = NSManagedObject(entity: entity!, insertInto: context)
                    newServer.setValue("World of Tanks", forKey: "game")
                    newServer.setValue(data.server, forKey: "server")
                    newServer.setValue(data.players_online, forKey: "players_online")
                    do {
                        try context.save()
                    } catch {
                        print("Failed saving")
                    }
                }
                
                for data in serverStats.data.wows
                {
                    let newServer = NSManagedObject(entity: entity!, insertInto: context)
                    newServer.setValue("World of Warships", forKey: "game")
                    newServer.setValue(data.server, forKey: "server")
                    newServer.setValue(data.players_online, forKey: "players_online")
                    do {
                        try context.save()
                    } catch {
                        print("Failed saving")
                    }
                }
                
                for data in serverStats.data.wotb
                {
                    let newServer = NSManagedObject(entity: entity!, insertInto: context)
                    newServer.setValue("World of Tanks Blitz", forKey: "game")
                    newServer.setValue(data.server, forKey: "server")
                    newServer.setValue(data.players_online, forKey: "players_online")
                    do {
                        try context.save()
                    } catch {
                        print("Failed saving")
                    }
                }
            }
            catch let jsonErr
            {
                print("Error serializing JSON", jsonErr)
            }
            group.leave()        }
        task.resume()
    }
}
