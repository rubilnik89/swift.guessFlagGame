//
//  FlagImage.swift
//  GuessFlagGame
//
//  Created by Roman Zherebko on 21.05.2022.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(imageName: "Italy")
    }
}
