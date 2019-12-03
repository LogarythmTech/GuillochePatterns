//
//  ContentView.swift
//  GuillochePatterns
//
//  Created by Logan Richards on 12/2/19.
//  Copyright © 2019 ZER0 Tech. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		SuperformulaCurve(a: 1, b: 1, m1: 8, m2: 8, n1: 8, n2: 8, n3: 8, radius: 160, steps: 350)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView().previewLayout(.fixed(width: 500, height: 500))
    }
}
