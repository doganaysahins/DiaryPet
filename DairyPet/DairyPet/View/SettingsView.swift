//
//  SettingsView.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 18.05.2022.
//

import SwiftUI
import Charts

struct SettingsView: View {
    var demoData: [Int] = [1, 2, 3, 6, 12, 2, 2]
    var body: some View {
        VStack{
            
            Chart(data: [0.5, 0.5, 0.9, 0.4])
                .chartStyle(
                    StackedColumnChartStyle(spacing: 2, cornerRadius: 3, colors: [.yellow, .orange, .red])
                )
        

            

        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
