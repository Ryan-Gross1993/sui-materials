/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct ContentView: View {
	@State var game = Game()
	@State var guess: RGB
	@State var showScore = false
	
	private let buttonWidth: CGFloat = 0.87
	private let circleSize: CGFloat = 0.5
	private let labelHeight: CGFloat = 0.06
	private let labelWidth: CGFloat = 0.53
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				Color.element
					.edgesIgnoringSafeArea(.all)
				VStack {
					ColorCircle(rgb: game.target, size: geometry.size.width * circleSize)
					if !showScore {
						//					Text("R: ??? G: ??? B: ???")
						//						.padding()
						BevelText(text: "R: ??? G: ??? B: ???", height: geometry.size.height * labelHeight, width: geometry.size.width * labelWidth)
					} else {
						BevelText(text:game.target.intString, height: geometry.size.height * labelHeight, width: geometry.size.width * labelWidth)
						//					Text(game.target.intString)
						//						.padding()
					}
					ColorCircle(rgb: guess, size: geometry.size.width * circleSize)
					BevelText(text: guess.intString, height: geometry.size.height * labelHeight, width: geometry.size.width * labelWidth)
					//				Text(guess.intString)
					//					.bold()
					//					.lineLimit(0)
					
					ColorSlider(value: $guess.red, trackColor: .red)
					ColorSlider(value: $guess.green, trackColor: .green)
					ColorSlider(value: $guess.blue, trackColor: .blue)
					Button("Hit Me!") {
						self.showScore = true
						self.game.check(guess: guess)
					}
					.buttonStyle(NeuButtonStyle(height: geometry.size.height * labelHeight, width: geometry.size.width * buttonWidth))
					//				.frame(width: 327, height: 48)
					//				.background(Capsule()
					//								.fill(Color.element)
					//								.northWestShadow())
					.alert(isPresented: $showScore) {
						Alert(
							title: Text("Your Score"),
							message: Text(String(game.scoreRound)),
							dismissButton: .default(Text("OK")) {
								self.game.startNewRound()
								self.guess = RGB()
							})
					}
				}
				.font(.headline)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			ContentView(guess: RGB())
				.previewDevice("iPhone 8")
			ContentView(guess: RGB())
				.previewDevice("iPhone 12 Pro Max")
				.preferredColorScheme(.dark)
			
		}
	}
}

struct ColorSlider: View {
	@Binding var value: Double
	var trackColor: Color
	var body: some View {
		HStack {
			Text("0")
			Slider(value: $value)
				.accentColor(trackColor)
			Text("255")
		}
		.padding(.horizontal)
		.font(.subheadline)
	}
}
