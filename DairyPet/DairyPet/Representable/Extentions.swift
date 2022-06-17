//
//  Extentions.swift
//  DairyPet
//
//  Created by Doğanay Şahin on 18.05.2022.
//

import Foundation
import SwiftUI

extension Color {
    static let darkPink = Color(red: 208 / 255, green: 45 / 255, blue: 208 / 255)
}
extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(.gray))
            
//            .foregroundColor(.gray)
            .padding(10)
    }
}



#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Color {

    var components: (red: Double, green: Double, blue: Double, alpha: Double) {
        
        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard NativeColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return (0,0,0,0) }
        
        return (Double(red), Double(green), Double(blue), Double(alpha))
    }
}


struct EmptyPlaceholderModifier<Items: Collection>: ViewModifier {
    let items: Items
    let placeholder: AnyView

    @ViewBuilder func body(content: Content) -> some View {
        if !items.isEmpty {
            content
        } else {
            placeholder
        }
    }
}

extension View {
    func emptyPlaceholder<Items: Collection, PlaceholderView: View>(_ items: Items, _ placeholder: @escaping () -> PlaceholderView) -> some View {
        modifier(EmptyPlaceholderModifier(items: items, placeholder: AnyView(placeholder())))
    }
}
