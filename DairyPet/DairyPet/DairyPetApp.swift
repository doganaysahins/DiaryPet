//
//  DairyPetApp.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 18.05.2022.
//

import SwiftUI

@main
struct DairyPetApp: App {
    var body: some Scene {
        WindowGroup {
            TabbarView()
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
