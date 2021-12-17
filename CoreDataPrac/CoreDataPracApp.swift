//
//  CoreDataPracApp.swift
//  CoreDataPrac
//
//  Created by 野中祐希 on 2021/12/17.
//

import SwiftUI

@main
struct CoreDataPracApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
