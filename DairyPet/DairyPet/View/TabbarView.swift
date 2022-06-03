//
//  TabbarView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 18.05.2022.
//

import SwiftUI

struct TabbarView: View {
    @State var tabTagHome = 0
    @State var tabTagCal = 1
    @State var tabTagSet = 2
    @State var selectedTab = false
    @State var currentDate = Date()
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                
                    Label("Home"  , systemImage: "homekit")
                        .tag(0)
                        
                        
                }
               

            CustomDatePicker(currentDate: $currentDate)
                .tabItem {
                    
                    Label("Calendar" , systemImage: "calendar")
                        .tag(1)
                       
                }
              
                
            
           SettingsView()
                
                .tabItem {
                    Label("Settings" , systemImage: "gear")
                        .tag(2)
                        
                }
            
            NewScrollView()
                 
                 .tabItem {
                     Label("Settings" , systemImage: "gear")
                         .tag(2)
                         
                 }

                
                
        }
        
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
