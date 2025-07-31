//
//  SQLIteDatabase.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 31.7.2023.
//

//import UIKit
//import SQLite
//
//
//// Create a connection to the SQLite database
//var db: Connection?
//
//func setupMessages() {
//    do {
//        // Get the path to the SQLite database file in the app's "Documents" directory
//        let databasePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("messages.sqlite3").path
//
//        // Establish a connection to the database
//        db = try Connection(databasePath)
//
//        // Define the table structure using Table, Column, and Expression classes
//        let messagesTable = Table("messages")
//        let id = Expression<String>("id")
//        let chatroom = Expression<ChatRoom>("chatroom")
//        // Define other columns...
//
//        // Check if the table exists in the database, and if not, create it
//        try db?.run(messagesTable.create(ifNotExists: true) { table in
//            table.column(id, primaryKey: true)
//            table.column(chatroom)
//            // Define other columns...
//        })
//
//        print("Database setup successful.")
//    } catch {
//        print("Error setting up database: \(error)")
//    }
//}
