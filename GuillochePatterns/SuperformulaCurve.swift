//
//  SuperformulaCurve.swift
//  GuillochePatterns
//
//  Created by Logan Richards on 12/2/19.
//  Copyright © 2019 ZER0 Tech. All rights reserved.
//

import SwiftUI

struct SuperformulaCurve: View {
	let a: Double
	let b: Double
	let m1: Double
	let m2: Double
	let n1: Double
	let n2: Double
	let n3: Double
	let radius: Double
	let steps: Double
	
	var x: Double = 250
	var y: Double = 250
	
    var body: some View {
		Path { path in
			var current: Double = 0
			
			
			
			var r = pow(pow(abs((cos((m1*current)/4)) / a), n2) + pow(abs((sin((m2*current)/4))/b),n3), -1/n1)*radius
			path.move(to: CGPoint(x: r*cos(current) + x, y: r*sin(current) + y))
			
			repeat {
				current = current + (2*Double.pi/steps)
				r = pow(pow(abs((cos((m1*current)/4))/a),n2)+pow(abs((sin((m2*current)/4))/b),n3), -1/n1)*radius
				path.addLine(to: CGPoint(x: r*cos(current) + x, y: r*sin(current) + y))
			} while current <= Double.pi*2
		}.stroke(Color.blue, lineWidth: 5)
	}
}



struct SuperformulaCurve_Previews: PreviewProvider {
    static var previews: some View {
        SuperformulaCurve(a: 1, b: 1, m1: 8, m2: 8, n1: 8, n2: 8, n3: 8, radius: 160, steps: 350).previewLayout(.fixed(width: 500, height: 500))
    }
}
