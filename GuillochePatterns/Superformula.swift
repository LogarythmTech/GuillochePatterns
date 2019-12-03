//
//  SuperformulaCurve.swift
//  GuillochePatterns
//
//  Created by Logan Richards on 12/2/19.
//  Copyright © 2019 ZER0 Tech. All rights reserved.
//

import SwiftUI

struct SuperformulaCurveEditor: View {
	@State private var a: Double = 1
	@State private var b: Double = 1
	@State private var m1: Double = 8
	@State private var m2: Double = 8
	@State private var n1: Double = 8
	@State private var n2: Double = 8
	@State private var n3: Double = 8
	@State private var radius: Double = 160
	@State private var steps: Double = 350
	
    var body: some View {
		VStack {
			drawCurve(myCurve: SuperformulaCurve(a: a, b: b, m1: m1, m2: m2, n1: n1, n2: n2, n3: n3, radius: radius, steps: steps), at: CGPoint(x: 200, y: 200)).frame(width: 400, height: 400, alignment: .center)
			
			HStack {
				Text("a")
				Slider(value: $a, in: 1...10, step: 0.1)
				Text("\(a)")
			}.padding(.leading).padding(.trailing)
			
			HStack {
				Text("b")
				Slider(value: $b, in: 1...10, step: 0.1)
				Text("\(b)")
			}.padding(.leading).padding(.trailing)
			
			HStack {
				Text("m1")
				Slider(value: $m1, in: 1...20, step: 0.1)
				Text("\(m1)")
			}.padding(.leading).padding(.trailing)
			
			HStack {
				Text("m2")
				Slider(value: $m2, in: 1...20, step: 0.1)
				Text("\(m2)")
			}.padding(.leading).padding(.trailing)
			
			HStack {
				Text("n1")
				Slider(value: $n1, in: 1...20, step: 0.1)
				Text("\(n1)")
			}.padding(.leading).padding(.trailing)
			
			HStack {
				Text("n2")
				Slider(value: $n2, in: 1...20, step: 0.1)
				Text("\(n2)")
			}.padding(.leading).padding(.trailing)
			
			HStack {
				Text("n3")
				Slider(value: $n3, in: 1...20, step: 0.1)
				Text("\(n3)")
			}.padding(.leading).padding(.trailing)
			
			HStack {
				Text("radius")
				Slider(value: $radius, in: 50...1000, step: 1)
				Text("\(radius)")
			}.padding(.leading).padding(.trailing)
			
			HStack {
				Text("steps")
				Slider(value: $steps, in: 50...1000, step: 1)
				Text("\(steps)")
			}.padding(.leading).padding(.trailing)
		}
    }
}

struct SuperformulaCurve {
	let a: Double
	let b: Double
	let m1: Double
	let m2: Double
	let n1: Double
	let n2: Double
	let n3: Double
	let radius: Double
	let steps: Double
	var points: [CGPoint]
		
	init(a: Double, b: Double, m1: Double, m2: Double, n1: Double, n2: Double, n3: Double, radius: Double, steps: Double) {
		self.a = a
		self.b = b
		self.m1 = m1
		self.m2 = m2
		self.n1 = n1
		self.n2 = n2
		self.n3 = n3
		self.radius = radius
		self.steps = steps
		
		self.points = [CGPoint]()
		self.calculatePoints()
	}
	
	private mutating func calculatePoints() {
		self.points = [CGPoint]()
		var current: Double = 0
		var r = pow(pow(abs((cos((m1*current)/4)) / a), n2) + pow(abs((sin((m2*current)/4))/b),n3), -1/n1)*radius
		
		self.points.append(CGPoint(x: r*cos(current), y: r*sin(current)))
		
		repeat {
			current = current + (2*Double.pi/steps)
			r = pow(pow(abs((cos((m1*current)/4))/a),n2)+pow(abs((sin((m2*current)/4))/b),n3), -1/n1)*radius
			self.points.append(CGPoint(x: r*cos(current), y: r*sin(current)))
		} while current <= Double.pi*2
	}
}

struct drawCurve : View {
	let myCurve: SuperformulaCurve
	var color: Color = .blue
	var at: CGPoint = CGPoint(x: 0, y: 0)
	
	var path: Path {
		get {
			let newPath = Path { path in
				for i in 0..<myCurve.points.count {
					if(i == 0) {
						path.move(to: myCurve.points[i] + at)
					} else {
						path.addLine(to: myCurve.points[i] + at)
					}
				}
			}
			
			return newPath
		}
	}
	
    var body: some View {
		path.stroke(color, lineWidth: 1)
	}
}

struct SuperformulaCurve_Previews: PreviewProvider {
    static var previews: some View {
        SuperformulaCurveEditor()
    }
}

extension CGPoint {
	public static func +(left: CGPoint, right: CGPoint) -> CGPoint {
		return CGPoint(x: left.x + right.x, y: left.y + right.y)
	}
}

extension Color {
    var redComponent: Double? {
        let val = description
        guard description.hasPrefix("#") else { return nil }
        let r1 = val.index(val.startIndex, offsetBy: 1)
        let r2 = val.index(val.startIndex, offsetBy: 2)
        return Double(Int(val[r1...r2], radix: 16)!) / 255.0
    }

    var greenComponent: Double? {
        let val = description
        guard description.hasPrefix("#") else { return nil }
        let g1 = val.index(val.startIndex, offsetBy: 3)
        let g2 = val.index(val.startIndex, offsetBy: 4)
        return Double(Int(val[g1...g2], radix: 16)!) / 255.0
    }

    var blueComponent: Double? {
        let val = description
        guard description.hasPrefix("#") else { return nil }
        let b1 = val.index(val.startIndex, offsetBy: 5)
        let b2 = val.index(val.startIndex, offsetBy: 6)
        return Double(Int(val[b1...b2], radix: 16)!) / 255.0
    }

    var opacityComponent: Double? {
        let val = description
        guard description.hasPrefix("#") else { return nil }
        let b1 = val.index(val.startIndex, offsetBy: 7)
        let b2 = val.index(val.startIndex, offsetBy: 8)
        return Double(Int(val[b1...b2], radix: 16)!) / 255.0
    }
}
