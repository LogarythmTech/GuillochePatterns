//
//  Spirograph.swift
//  GuillochePatterns
//
//  Created by Logan Richards on 12/3/19.
//  Copyright © 2019 ZER0 Tech. All rights reserved.
//

import SwiftUI

struct SpirographEditor : View {
	@State private var one_a: Double = 1
	@State private var one_b: Double = 1
	@State private var one_m1: Double = 8
	@State private var one_m2: Double = 8
	@State private var one_n1: Double = 8
	@State private var one_n2: Double = 8
	@State private var one_n3: Double = 8
	@State private var one_radius: Double = 160
	@State private var one_steps: Double = 350
	
	@State private var two_a: Double = 1
	@State private var two_b: Double = 1
	@State private var two_m1: Double = 8
	@State private var two_m2: Double = 8
	@State private var two_n1: Double = 8
	@State private var two_n2: Double = 8
	@State private var two_n3: Double = 8
	@State private var two_radius: Double = 160
	@State private var two_steps: Double = 350
	
	var body: some View {
		Spirograph(path1: SuperformulaCurve(a: one_a, b: one_b, m1: one_m1, m2: one_m2, n1: one_n1, n2: one_n2, n3: one_n3, radius: one_radius, steps: one_steps),
				   path2: SuperformulaCurve(a: two_a, b: two_b, m1: two_m1, m2: two_m2, n1: two_n1, n2: two_n2, n3: two_n3, radius: two_radius, steps: two_steps),
				   color1: Color(red: 1, green: 0, blue: 0),
				   color2: Color(red: 0, green: 0, blue: 1),
				   rotation: 0)
	}
}

struct Spirograph : View {
	let path1: SuperformulaCurve
	let path2: SuperformulaCurve
	let color1: Color
	let color2: Color
	let rotation: Double
	
    private func getColorGradientStep(step: Int, totalSteps: Int) -> Color {
		let color1Red: Double = color1.redComponent ?? 0
		let color1Green: Double = color1.greenComponent ?? 0
		let color1Blue: Double = color1.blueComponent ?? 0
		
		let color2Red: Double = color2.redComponent ?? 1
		let color2Green: Double = color2.greenComponent ?? 1
		let color2Blue: Double = color2.blueComponent ?? 1
        
		
        let redDelta: Double = (color2Red - color1Red)
        let blueDelta: Double = (color2Blue - color1Blue)
        let greenDelta: Double = (color2Green - color1Green)
        
		let sineCorrection: Double = sin(Double.pi * Double(step)/Double(totalSteps))
        return Color(red: color1Red + redDelta * sineCorrection,
					 green: color1Green + greenDelta * sineCorrection,
					 blue: color1Blue + blueDelta * sineCorrection)
    }
	
	
	var body: some View {
		ZStack {
			ForEach(0..<self.path1.points.count) { i in
				SuperShape(curve: self.path2, at: self.path1.points[i]).stroke(self.getColorGradientStep(step: i, totalSteps: self.path1.points.count), lineWidth: 1)
					/*.rotationEffect(.radians(Double(i)*self.rotation), anchor: .init(x: self.path1.getPoints()[i].x, y: self.path1.getPoints()[i].y))*/
			}
		}
	}
}

struct Spirograph_Previews: PreviewProvider {
    static var previews: some View {
        Spirograph(path1: SuperformulaCurve(a: 1, b: 1, m1: 8, m2: 8, n1: 8, n2: 8, n3: 8, radius: 160, steps: 350),
				   path2: SuperformulaCurve(a: 1, b: 1, m1: 6, m2: 6, n1: 12, n2: 12, n3: 12, radius: 80, steps: 350),
				   color1: Color(red: 1, green: 0, blue: 0),
				   color2: Color(red: 0, green: 0, blue: 1),
				   rotation: 0)
    }
}
