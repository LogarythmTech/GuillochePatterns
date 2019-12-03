//
//  ContentView.swift
//  GuillochePatterns
//
//  Created by Logan Richards on 12/2/19.
//  Copyright © 2019 ZER0 Tech. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	let path1: SuperformulaCurve = SuperformulaCurve(a: 1, b: 1, m1: 8, m2: 8, n1: 8, n2: 8, n3: 8, radius: 160, steps: 350)
	let path2: SuperformulaCurve = SuperformulaCurve(a: 1, b: 1, m1: 6, m2: 6, n1: 12, n2: 12, n3: 12, radius: 80, steps: 350)
	let at = CGPoint(x: 200, y: 350)
	
    var body: some View {
		ZStack {
			Spirograph(path1: path1, path2: path2,
					   color1: Color(red: 0, green: 0, blue: 1), color2: Color(red: 1, green: 0, blue: 0),
					   rotation: 0, at: at)
		}
	}
}

struct Spirograph : View {
	let path1: SuperformulaCurve
	let path2: SuperformulaCurve
	let color1: Color
	let color2: Color
	let rotation: Double
	let at: CGPoint
	
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
		ForEach(0..<path1.getPoints().count) { i in
			drawCurve(myCurve: self.path2, color: self.getColorGradientStep(step: i, totalSteps: self.path1.getPoints().count), at: self.path1.getPoints()[i] + self.at)
				/*.rotationEffect(.radians(Double(i)*self.rotation), anchor: .init(x: self.path1.getPoints()[i].x, y: self.path1.getPoints()[i].y))*/
		}
	}
	
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}

