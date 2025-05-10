import SwiftUI

struct GameOverView: View {
    var hasWon: Bool
    var hasLost: Bool
    var resetAction: () -> Void

    var body: some View {
        ZStack {
            if hasWon {
                VStack(spacing: 12) {
                    Text("Challenge completed 🎉")
                        .font(.title)
                        .foregroundColor(Color.green)
                    Spacer()
                    Button("Reset Board", action: resetAction)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else if hasLost {
                VStack(spacing: 12) {
                    Text("Challenge failed 💀")
                        .font(.title)
                        .foregroundColor(.red)
                    Spacer()
                    Button("Try Again", action: resetAction)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .frame(height: 120)
    }
}
