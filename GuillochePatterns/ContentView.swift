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
		VStack {
			Spirograph(path1: SuperformulaCurve(a: 1, b: 1, m1: 8, m2: 8, n1: 8, n2: 8, n3: 8, radius: 160, steps: 350),
					   path2: SuperformulaCurve(a: 1, b: 1, m1: 6, m2: 6, n1: 12, n2: 12, n3: 12, radius: 80, steps: 350),
					   color1: Color(red: 1, green: 0, blue: 0),
					   color2: Color(red: 0, green: 0, blue: 1),
					   rotation: 0)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}

