//
//  City_Sights_AppApp.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/25/22.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
