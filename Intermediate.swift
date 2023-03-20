import SwiftUI
import AVFoundation
struct Intermediate: View {
    @State private var colors = [Color.red, Color.green, Color.blue, Color.orange, Color.yellow, Color.purple, Color.cyan, Color.pink, Color.brown, Color.gray, Color.mint, Color.indigo, Color.teal]
    @State private var currentColor = Color.red
    @State private var currentColorIndex = 0
    @State private var score = 0
    @State private var showingScore = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var round = 1
    @State private var isPlaying = false
    @State private var secondsRemaining = 60
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var gameover = false

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [currentColor, Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Tap the color of the text")
                    .foregroundColor(.white)
                    .font(.headline)
                Text(currentColor.description)
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                Text("Round: \(round)")
                    .foregroundColor(.white)
                    .font(.headline)
                Text("Time: \(self.secondsRemaining)")
                    .foregroundColor(.white)
                    .font(.headline)
                ForEach(0 ..< 4) { row in
                    HStack {
                        ForEach(0 ..< 3) { column in
                            Button(action: {
                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                self.colorTapped(row, column)
                            }) {
                                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                                    .fill(self.colors[row * 3 + column])
                                    .frame(width: 100, height: 100)
                            }
                        }
                    }
                }
                .onReceive(self.timer) { time in
                    if self.secondsRemaining > 0 {
                        self.secondsRemaining -= 1
                    } else {
                        //ContentView()
                        self.timer.upstream.connect().cancel()
                        self.showingScore = true
                    }
                }
            }
        }
    }
    
    func colorTapped(_ row: Int, _ column: Int) {
        @Binding var isPlaying: Bool
        let tappedColor = colors[row * 3 + column]
        self.isPlaying.toggle()
        AudioServicesPlaySystemSound(1306)
        if tappedColor == currentColor {
            score += 1
        } else {
            score -= 1
            alertTitle = "Wrong"
            alertMessage = "That's the color \(tappedColor.description), not \(currentColor.description)"
        }
        colors.shuffle()
        currentColorIndex = Int.random(in: 0...5)
        currentColor = colors[currentColorIndex]
        round += 1
        showingScore = true
    }
}
