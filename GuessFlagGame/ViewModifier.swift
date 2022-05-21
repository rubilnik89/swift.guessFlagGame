//
//  ViewModifier.swift
//  GuessFlagGame
//
//  Created by Roman Zherebko on 21.05.2022.
//

import Foundation
import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.mint)
//            .padding()
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}
