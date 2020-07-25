//
//  CView.swift
//  Tangent
//
//  Created by Shaurya Pathak on 7/18/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import SwiftUI

struct CircleView : View {
    @ObservedObject var model: CircleModel

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue)
            Text(model.text)
                .foregroundColor(Color.white)
        }
    }
}

import Combine

class CircleModel: ObservableObject {
    @Published var text: String

    init(text: String) {
        self.text = text
    }
}
